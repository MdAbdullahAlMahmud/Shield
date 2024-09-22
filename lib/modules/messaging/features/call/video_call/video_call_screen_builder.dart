import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shield/core/constants/app_spaces.dart';
import 'package:shield/modules/messaging/features/call/video_call/widgets/call_circle_button.dart';
import 'package:shield/modules/messaging/utils/chat_utils.dart';

import 'audio_profile_view.dart';

enum CallState {
  calling,
  ringing,
  connected,
}

class VideoCallScreenBuilder extends StatefulWidget {
  final dynamic data;

  const VideoCallScreenBuilder({Key? key, this.data}) : super(key: key);

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreenBuilder>
    with TickerProviderStateMixin {
  bool isMuted = false;
  bool isCameraOff = false;
  bool isFrontCamera = true;
  CallState callState = CallState.calling;

  String? securedEmojis;

  // Simulate actions with a controller
  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void toggleCamera() {
    setState(() {
      isCameraOff = !isCameraOff;
    });
  }

  void switchCamera() {
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
  }

  // Centralized colors for easy theming
  final Color primaryColor = Colors.blueAccent;
  final Color secondaryColor = Colors.white;
  final Color accentColor = Colors.redAccent;
  Timer? _timer;
  int _callDuration = 0;

  @override
  void initState() {
    super.initState();
    securedEmojis = ChatUtils.getSecuredCallEmojis();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  // Change call state based on user interaction or status
  void changeCallState(CallState newState) {
    setState(() {
      callState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Show different backgrounds based on video toggle
          Positioned.fill(
            child: isCameraOff ? audioCallBackground() : videoCallBackground(),
          ),

          // Call status text positioned at the top center
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Optional horizontal padding
              child: Column(
                children: [
                  /*Text(
                    _getCallStatusText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),*/

                  AppSpaces.spaceBetweenChild,
                  Text(
                    securedEmojis ?? "", // Get 4 to 5 emojis
                    style: TextStyle(
                      fontSize: 18, // Match the size of call status text
                    ),
                  ),

                  AppSpaces.spaceBetweenChild,
                  // Call Duration Text
                  Text(
                    _formatDuration(_callDuration),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Self View (small video window if video is on)
          if (!isCameraOff)
            Positioned(
              right: 20,
              bottom: 160,
              child: Draggable(
                feedback: selfViewWidget(),
                child: selfViewWidget(),
                childWhenDragging: Container(),
              ),
            ),

          // Control Buttons
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controlPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to get status text based on call state
  String _getCallStatusText() {
    switch (callState) {
      case CallState.calling:
        return 'Calling...';
      case CallState.ringing:
        return 'Ringing...';
      case CallState.connected:
        return 'Connected';
      default:
        return '';
    }
  }

  // Widget for the video call background (when video is on)
  Widget videoCallBackground() {
    return Container(
      color: Colors.grey[900], // Simulated video background
      child: Center(
        child: Text(
          'Remote Video',
          style: TextStyle(color: secondaryColor, fontSize: 24),
        ),
      ),
    );
  }

  // Widget for the audio call background (color-shifting animation)
  Widget audioCallBackground() {
    return AudioCallProfileView(
      userName: "John Doe",
      userImageUrl:
          "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg", // Replace with actual user image URL
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _callDuration++;
      });
    });
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  // Self-view widget (small camera view)
  Widget selfViewWidget() {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          isCameraOff ? 'Camera Off' : 'Your Video',
          style: TextStyle(color: secondaryColor),
        ),
      ),
    );
  }

  // Control panel at the bottom
  Widget controlPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Mute Button
        CircleButton(
          icon: Icons.mic_off,
          onPressed: toggleMute,
          color: isMuted ? accentColor : primaryColor,
        ),

        // Camera Toggle Button
        CircleButton(
          icon: Icons.videocam_off,
          onPressed: toggleCamera,
          color: isCameraOff ? accentColor : primaryColor,
        ),

        // Switch Camera Button
        CircleButton(
          icon: Icons.cameraswitch,
          onPressed: switchCamera,
          color: primaryColor,
        ),

        // End Call Button
        CircleButton(
          icon: Icons.call_end,
          onPressed: () {
            // Simulate ending the call
            Navigator.pop(context);
          },
          color: accentColor,
        ),
      ],
    );
  }
}
