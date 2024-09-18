import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/core/constants/app_spaces.dart';
import 'package:shield/modules/messaging/data/model/message_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ChatSupabaseScreenBuilder extends StatefulWidget {
  final dynamic data;
   String?  currentUserId;
  String? chatRoomId;

  ChatSupabaseScreenBuilder({this.data}) {
    currentUserId = data['currentUserId'].toString();
    chatRoomId = data['chatRoomId'].toString();
  }

  @override
  State<ChatSupabaseScreenBuilder> createState() => _ChatSupabaseScreenBuilderState();
}

class _ChatSupabaseScreenBuilderState extends State<ChatSupabaseScreenBuilder> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showEmoji = false;
  List<MessageItem> _messages = [];
  late Stream<List<Map<String, dynamic>>> _messagesStream;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _subscribeToMessages();
  }

  Future<void> _loadMessages() async {
    final response = await Supabase.instance.client
        .from('messages')
        .select()
        .eq('chat_room_id', widget.chatRoomId)
        .order('created_at', ascending: true) // Change back to ascending order
        .execute();

    if (response.data != null) {
      setState(() {
        _messages = (response.data as List<dynamic>)
            .map((message) => MessageItem.fromJson(message))
            .toList();
      });
      _scrollToBottom();
    } else {
      // Handle error
      print('Error loading messages: ${response.data ?? "Unknown error"}');
    }
  }

  void _subscribeToMessages() {
    _messagesStream = Supabase.instance.client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_room_id', widget.chatRoomId)
        .order('created_at', ascending: true) // Change back to ascending order
        .map((List<Map<String, dynamic>> data) => data);

    _messagesStream.listen((List<Map<String, dynamic>> data) {
      setState(() {
        _messages = data.map((message) => MessageItem.fromJson(message)).toList();
      });
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final newMessage = {
        'id': const Uuid().v4(), // Generate a new UUID for the message
        'chat_room_id': widget.chatRoomId,
        'sender_id': widget.currentUserId,
        'content': _messageController.text,
        'created_at': DateTime.now().toIso8601String(), // Add created_at field
      };

      final response = await Supabase.instance.client
          .from('messages')
          .insert(newMessage)
          .execute();

      if (response.status != 201) {
        // Handle error
        print('Error sending message: ${response.data!}');
      } else {
        _messageController.clear();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmoji = !_showEmoji;
    });
  }

  void _onEmojiSelected(Category? category, Emoji emoji) {
    _messageController.text += emoji.emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              // TODO: Implement video call functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              // TODO: Implement audio call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          if (_showEmoji)
            SizedBox(
              height: 250,
              child: EmojiPicker(
                onEmojiSelected: _onEmojiSelected,
                config: Config(
                  columns: 7,
                  emojiSizeMax: 32.0,
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  initCategory: Category.RECENT,
                  bgColor: Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  recentsLimit: 28,
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                ),
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.emoji_emotions),
                  onPressed: _toggleEmojiPicker,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
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
          AppSpaces.spaceBetweenChild
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageItem message) {
    final isCurrentUser = message.senderId == widget.currentUserId;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.content,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

