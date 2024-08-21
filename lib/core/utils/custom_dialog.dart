import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shield/core/services/navigator/app_navigator_service.dart';
import 'package:shield/router/app_routes.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

showCustomDialog(message,
    {title,
      String? positiveButtonText,
      String? negativeButtonText,
      bool isCancelAble=true,
      Function()? positiveButtonAction,
      Function()? negativeButtonAction,
      bool willPopOnPositiveAction=true,
      bool willPopOnNegativeAction=true,
      GlobalKey? key}) {
  showDialog(
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          return;
        },
        child: CupertinoAlertDialog(
          key: key,
          title: Text(
            title ?? "",
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
             message
            ),
          ),
          actions: <Widget>[
            if (negativeButtonAction != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  AppRoutes.pop();
                },
                child: Text(
                  "Cancel",
                ),
              ),
            if(isCancelAble)ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                "Ok",
              ),
              onPressed: () {
                AppRoutes.pop();
                positiveButtonAction?.call();
              },
            ),
          ],
        ),
      );
    },
    context: AppNavigatorService.navigatorKey.currentContext!,
  );
}