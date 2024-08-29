import 'package:flutter/material.dart';
import 'package:shield/core/base/base_view.dart';
import 'package:shield/core/constants/app_spaces.dart';
import 'package:shield/core/widgets/text_filed/app_text.dart';
import 'package:shield/modules/messaging/features/chat_users_list/controller/chat_users_list_controller.dart';

import '../../../../../core/theme/color_palettes.dart';
import '../../../../../core/widgets/text_filed/header_widget.dart';
import '../../../../../core/widgets/text_filed/input_field.dart';

/**
 * Created by Abdullah on 25/8/24.
 */

class ChatUsersListScreenBuilder extends BaseView<ChatUsersListController> {
  ChatUsersListScreenBuilder({super.key}) {
    controller.onInit();
  }

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: Text('User connection Bridger'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWidget(
          "User ID",
        ),
        InputField(
          controller: controller.userIdController,
          keyboardType: TextInputType.number,
          label: "User ID",
        ),
        AppSpaces.spaceBetweenChild,
        HeaderWidget(
          "Peer ID",
        ),
        InputField(
          controller: controller.peerIdController,
          keyboardType: TextInputType.number,
          label: "peer ID",
        ),
        AppSpaces.spaceBetweenChild,
        ElevatedButton(
          onPressed: controller.connectToUser,
          child: AppText("Connect"),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalettes.colorAccent,
          ),
        ),
      ],
    );
  }
}
