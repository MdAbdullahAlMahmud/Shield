import 'package:go_router/go_router.dart';
import 'package:shield/modules/authentication/features/login/views/login_screen.dart';
import 'package:shield/modules/authentication/features/sign_up/views/sign_up_screen.dart';
import 'package:shield/router/route_path.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

abstract class AppRoutesList {
  static allRoutes() {
    return [
      GoRoute(
        path: '/',
        name: '/',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: RoutePath.signUp,
        name: RoutePath.signUp,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: RoutePath.login,
        name: RoutePath.login,
        builder: (context, state) => LoginScreen(),
      ),
    ];
  }
}
