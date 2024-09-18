/**
 * Created by Abdullah on 25/8/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shield/core/base/base_controller.dart';
import 'package:shield/core/data/model/user.dart';
import 'package:shield/core/utils/custom_dialog.dart';
import 'package:shield/modules/messaging/data/repository/chat_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../router/app_routes.dart';
import '../../../../../router/route_path.dart';

class ChatUsersListController extends BaseController {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController peerIdController = TextEditingController();

  final ChatRepository _chatRepository;
  ChatUsersListController(this._chatRepository);
  // Rx Varibales

  RxList users  = RxList([]);
  @override
  void onInit() {
    getAllUserList();
    super.onInit();
  }

  void onUserTap(UserItem user){

    AppRoutes.pushNamed(RoutePath.chatSupabase, extra: {
      "currentUserId": Supabase.instance.client.auth.currentUser!.id,
      "chatRoomId": "3923af21-cbbd-46e1-a85f-78bc1b590e4b",
    });

  }
  void connectToUser() {
    final userId = userIdController.text;
    final peerId = peerIdController.text;
    if (userId.isNotEmpty && peerId.isNotEmpty) {
      AppRoutes.pushNamed(RoutePath.chat, extra: {
        "userId": userId,
        "peerId": peerId,
      });
    } else {
      showCustomDialog(
        "please enter user id and peer id",
        title: "User Connection Bridger",
      );
    }
  }

  void saveUser(){
    UserItem userItem = UserItem(
      uid: "aaaa-bbbb-cccc-dddd",
      name: "Test",
      email: "test@gmail.com",
      password: "12345678",
    );

    final saveRepo = _chatRepository.saveUser(userItem);
    execute(saveRepo, onSuccess: (response) {
     showCustomDialog("user saved successfully", title: "User Connection Bridger");
    }, onError: () {});
  }


  void getAllUserList(){
    final repo = _chatRepository.getAllUserList();
    execute(repo, onSuccess: (response) {
      users.value = response;
    });
  }

}
