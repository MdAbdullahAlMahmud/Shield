import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        ElevatedButton(
          onPressed: controller.saveUser,
          child: AppText("Save"),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalettes.colorAccent,
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
                itemBuilder: (context, position) {
                  return InkWell(
                    onTap: (){
                      controller.onUserTap(controller.users.value[position]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: ColorPalettes.colorAccent,
                          )
                        ),
                        title: AppText(controller.users.value[position].name),
                        subtitle: AppText(controller.users.value[position].email),
                        leading: Icon(
                          Icons.person,
                          color: ColorPalettes.colorAccent,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.users.value.length),
          ),
        )
      ],
    );
  }
}
