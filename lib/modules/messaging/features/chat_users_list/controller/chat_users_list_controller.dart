/**
 * Created by Abdullah on 25/8/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:shield/core/base/base_controller.dart';
import 'package:shield/core/utils/custom_dialog.dart';

import '../../../../../router/app_routes.dart';
import '../../../../../router/route_path.dart';

class ChatUsersListController extends BaseController {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController peerIdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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
}
