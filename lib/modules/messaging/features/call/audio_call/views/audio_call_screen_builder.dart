import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shield/modules/messaging/features/call/video_call/audio_profile_view.dart';
import 'package:shield/modules/messaging/features/call/video_call/widgets/call_circle_button.dart';

enum CallState {
  calling,
  ringing,
  connected,
}

class AudioCallScreenBuilder extends StatefulWidget {
  final dynamic data;

  const AudioCallScreenBuilder({Key? key, this.data}) : super(key: key);

  @override
  _AudioCallScreenBuilderState createState() => _AudioCallScreenBuilderState();
}

class _AudioCallScreenBuilderState extends State<AudioCallScreenBuilder>
    with TickerProviderStateMixin {
  bool isMuted = false;
  CallState callState = CallState.calling;

  Timer? _timer;
  int _callDuration = 0;

  // Centralized colors for easy theming
  final Color primaryColor = Colors.blueAccent;
  final Color secondaryColor = Colors.white;
  final Color accentColor = Colors.redAccent;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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

  // Simulate actions with a controller
  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
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
            child: audioCallBackground(),
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
                  Text(
                    _getCallStatusText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

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

  // Widget for the audio call background (color-shifting animation)
  Widget audioCallBackground() {
    return AudioCallProfileView(
      userName: "John Doe",
      userImageUrl:
          "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg", // Replace with actual user image URL
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
