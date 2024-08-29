import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

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
  final List<String> _messages = [];
  final List<String> _logs = [];
  String _connectionStatus = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initWebRTC();
    _initWebRTC();

    _webRTCService.onMessage.listen((message) {
      setState(() {
        _messages.add(message);
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
          _messages.add("Peer: $message");
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
        _messages.add("You: $message");
      });
      _messageController.clear();
    }
  }

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_messages[index]),
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
}
