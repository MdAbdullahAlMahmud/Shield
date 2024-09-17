import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shield/modules/messaging/data/model/message.dart';
import 'package:shield/modules/messaging/enums/message_type.dart'
    as MessageTypeEnum;
import 'package:shield/modules/messaging/widgets/message_widget.dart';

import '../../../data/services/webrtc_service.dart';

class ChatScreenBuilder extends StatefulWidget {
  final String userId;
  final String peerId;

  ChatScreenBuilder({required this.userId, required this.peerId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenBuilder> {
  final WebRTCService _webRTCService = WebRTCService();
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final List<String> _logs = [];
  String _connectionStatus = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initWebRTC();
    _initWebRTC();

    _webRTCService.onMessage.listen((message) {
      setState(() {
        _messages.add(Message(
          message: message,
          isOwn: false,
          messageType: MessageTypeEnum.MessageType.TEXT,
          sent: getMessageSentTime(),
          read: 'false',
        ));
      });
    });

    _webRTCService.onConnectionState.listen((state) {
      setState(() {
        _connectionStatus = state;
      });
    });
  }

  Future<void> _initWebRTC() async {
    try {
      setState(() {
        _connectionStatus = 'Initializing peer connection...';
        _addLog('Initializing WebRTC...');
      });

      await _webRTCService.initializePeerConnection(
        widget.userId,
        widget.peerId,
        onLog: _addLog,
        onConnectionStateChange: _handleConnectionStateChange,
      );

      setState(() {
        _connectionStatus = 'Peer connection initialized.';
        _addLog('Peer connection initialized.');
      });

      _webRTCService.onMessage.listen((message) {
        setState(() {
          _messages.add(Message(
            message: message,
            isOwn: false,
            messageType: MessageTypeEnum.MessageType.TEXT,
            sent: getMessageSentTime(),
            read: 'false',
          ));
        });
      });

      if (widget.userId.hashCode > widget.peerId.hashCode) {
        await _webRTCService.createOffer(widget.userId, widget.peerId);
        _addLog('Offer created and sent.');
      }
    } catch (e) {
      setState(() {
        _connectionStatus = 'Error: ${e.toString()}';
        _addLog('Error initializing WebRTC: ${e.toString()}');
      });
    }
  }

  void _handleConnectionStateChange(RTCPeerConnectionState state) {
    setState(() {
      _connectionStatus =
          'Connection state: ${state.toString().split('.').last}';
      _addLog(
          'Connection state changed to: ${state.toString().split('.').last}');
    });
  }

  void _addLog(String log) {
    setState(() {
      _logs.add("${DateTime.now().toString().split(' ').last}: $log");
      if (_logs.length > 100) {
        _logs.removeAt(0);
      }
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _webRTCService.sendMessage(message);
      setState(() {
        _messages.add(Message(
          message: message,
          isOwn: true,
          messageType: MessageTypeEnum.MessageType.TEXT,
          sent: getMessageSentTime(),
          read: 'false',
        ));
      });
      _messageController.clear();
    }
  }

  bool _showEmoji = false, _isUploading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.peerId}'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_connectionStatus,
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [Tab(text: 'Chat'), Tab(text: 'Logs')],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildChatList(),
                        _buildLogList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _chatInput(MediaQuery.of(context).size),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: MessageWidget(message: _messages[index]),
        );
      },
    );
  }

  Widget _buildLogList() {
    return ListView.builder(
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_logs[index], style: TextStyle(fontSize: 12)),
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _webRTCService.dispose();
    super.dispose();
  }

  String getMessageSentTime() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Widget _chatInput(Size mq) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.blueAccent, size: 25)),

                  Expanded(
                      child: TextField(
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Type Something...',
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),

                  //pick image from gallery button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.blueAccent, size: 26)),

                  //take image from camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          _logs.add('Image Path: ${image.path}');
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.blueAccent, size: 26)),

                  //adding some space
                  SizedBox(width: mq.width * .02),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              _sendMessage();
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }
}
