import 'dart:async';

import 'package:shield/core/data/model/user.dart';
import 'package:shield/modules/messaging/data/repository/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ChatRepositoryImpl extends ChatRepository{

  final SupabaseClient _client = Supabase.instance.client;
  @override
  Future<void> saveUser(UserItem user) {
    return _client.from('users').insert(user.toJson());
  }


  @override
  Future<List<UserItem>> getAllUserList()  {
    return _client
        .from('users')
        .select()
        .execute()
        .then((value) => (value.data as List<dynamic>)
            .map((user) => UserItem.fromJson(user))
            .toList());
  }

}