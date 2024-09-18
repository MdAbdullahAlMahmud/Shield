import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:shield/modules/messaging/data/services/call_service.dart';

class VideoCallScreenBuilder extends StatefulWidget {
  final dynamic data;

  const VideoCallScreenBuilder({super.key, this.data});
  @override
  _VideoCallScreenBuilderState createState() => _VideoCallScreenBuilderState();
}

class _VideoCallScreenBuilderState extends State<VideoCallScreenBuilder> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  CallService _webrtcService = CallService();

  @override
  void initState() {
    super.initState();
    _initRenderers();
    _startVideoCall();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _startVideoCall() async {
    // Initialize local stream and set up peer connection
    await _webrtcService.initLocalStream();

    // Set the local renderer stream
    _localRenderer.srcObject = _webrtcService.localStream;

    // Create a WebRTC peer connection and add the remote stream listener
    await _webrtcService.initializePeerConnection(
      onRemoteStream: (MediaStream stream) {
        setState(() {
          _remoteRenderer.srcObject = stream;
        });
      },
    );

    // Create an offer and send it to the remote peer via signaling (Supabase)
    await _webrtcService.createOffer('receiver-id');  // Replace with actual receiver ID
  }

  void _hangUp() {
    _webrtcService.hangup();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video
          Positioned.fill(
            child: RTCVideoView(_remoteRenderer),
          ),
          // Local video (small overlay)
          Positioned(
            right: 20,
            top: 50,
            child: Container(
              width: 120,
              height: 160,
              child: RTCVideoView(_localRenderer, mirror: true),
            ),
          ),
          // Hangup button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _hangUp,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(24),
                  backgroundColor: Colors.red,
                ),
                child: Icon(Icons.call_end, color: Colors.white, size: 36),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
