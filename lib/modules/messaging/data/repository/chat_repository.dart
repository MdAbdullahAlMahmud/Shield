
import 'package:shield/core/data/model/user.dart';

abstract class ChatRepository{
  Future<void> saveUser(UserItem user);
  Future<List<UserItem>> getAllUserList();
}