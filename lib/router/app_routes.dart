import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shield/core/services/navigator/app_navigator_service.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

class AppRoutes {
  static Future<dynamic> pushAndPopAll(String path, {extra}) async {
    return AppNavigatorService.navigatorKey.currentContext!
        .go(path, extra: extra);
  }

  static Future<dynamic> pushNamed(String path,
      {extra, Map<String, String>? pathParameters}) async {
    return AppNavigatorService.navigatorKey.currentContext!
        .pushNamed(path, extra: extra, pathParameters: pathParameters ?? {});
  }

  static Future<dynamic> pushAndReplaceNamed(String path, {extra}) async {
    return AppNavigatorService.navigatorKey.currentContext!
        .pushReplacementNamed(path, extra: extra);
  }

  static bool canPop() {
    return AppNavigatorService.navigatorKey.currentState!.canPop();
  }

  static popUntil(String keepUpto) {
    final navigator = AppNavigatorService.navigatorKey.currentState!;
    if (navigator != null && navigator.canPop()) {
      navigator.popUntil(ModalRoute.withName(keepUpto));
    }
  }

  static popWithoutData() {
    if (canPop()) {
      AppNavigatorService.navigatorKey.currentState!.pop();
    }
  }

  static popWithData(dynamic data) {
    if (canPop()) {
      AppNavigatorService.navigatorKey.currentState!.pop(data);
    }
  }

  static Future<dynamic> pop() async {
    return AppNavigatorService.navigatorKey.currentContext!.pop();
  }
}