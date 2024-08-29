import 'package:flutter/cupertino.dart';

import 'chat_screen_builder.dart';

/**
 * Created by Abdullah on 25/8/24.
 */

class ChatScreen extends StatelessWidget {
  final dynamic bridgeData;

  const ChatScreen({super.key, required this.bridgeData});

  @override
  Widget build(BuildContext context) {
    return ChatScreenBuilder(
      userId: bridgeData['userId'],
      peerId: bridgeData['peerId'],
    );
  }
}
