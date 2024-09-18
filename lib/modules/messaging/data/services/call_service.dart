import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CallService {
  RTCPeerConnection? _peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> initLocalStream() async {
    // Get local media stream for audio/video
    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
  }

  Future<void> initializePeerConnection({required Function(MediaStream) onRemoteStream}) async {
    final configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ]
    };
    try {

    _peerConnection = await createPeerConnection(configuration);

    // Add local stream to the peer connection
    localStream?.getTracks().forEach((track) {
      _peerConnection?.addTrack(track, localStream!);
    });

    // Listen for ICE candidates and handle signaling
    _peerConnection?.onIceCandidate = (candidate) {
      // Send ICE candidates via Supabase
      sendIceCandidate(candidate);
    };

    // Listen for remote stream and pass it to the callback
    _peerConnection?.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        onRemoteStream(event.streams[0]);
      }
    };
    }catch (e) {

    }
  }

  // Create an offer and send it via Supabase signaling
  Future<void> createOffer(String receiverId) async {
    final offer = await _peerConnection?.createOffer();
    await _peerConnection?.setLocalDescription(offer!);

    // Send the offer to the remote user via Supabase
    await supabase.from('calls').insert({
      'caller_id': supabase.auth.currentUser!.id,
      'receiver_id': receiverId,
      'offer': offer?.toMap(),
    });
  }

  // Send ICE candidates via Supabase
  Future<void> sendIceCandidate(RTCIceCandidate candidate) async {
    await supabase.from('calls').update({
      'ice_candidates': candidate.toMap(),
    });
  }

  void hangup() {
    _peerConnection?.close();
    _peerConnection = null;
  }
}
