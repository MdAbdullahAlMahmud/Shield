import 'package:flutter/cupertino.dart';

import 'chat_supabase_screen_builder.dart';

class ChatSupabaseScreen extends StatelessWidget {
  final dynamic data;
  const ChatSupabaseScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return ChatSupabaseScreenBuilder(data: data, );
  }
}