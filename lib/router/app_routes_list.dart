import 'package:go_router/go_router.dart';
import 'package:shield/modules/authentication/features/login/views/login_screen.dart';
import 'package:shield/modules/authentication/features/sign_up/views/sign_up_screen.dart';
import 'package:shield/modules/dashboard/features/dahboard/views/dashboard_screen.dart';
import 'package:shield/modules/messaging/features/chat/views/chat_screen.dart';
import 'package:shield/modules/messaging/features/chat_supabase/chat_supabase_screen.dart';
import 'package:shield/modules/messaging/features/chat_users_list/views/chat_users_list_screen.dart';
import 'package:shield/modules/splash_screen.dart';
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
        builder: (context, state) => SplashScreen(),
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
      GoRoute(
        path: RoutePath.dashboard,
        name: RoutePath.dashboard,
        builder: (context, state) => DashboardScreen(),
      ),
      GoRoute(
        path: RoutePath.chatUserList,
        name: RoutePath.chatUserList,
        builder: (context, state) => ChatUsersScreen(),
      ),
      GoRoute(
        path: RoutePath.chat,
        name: RoutePath.chat,
        builder: (context, state) => ChatScreen(bridgeData: state.extra),
      ),

      GoRoute(
        path: RoutePath.chatSupabase,
        name: RoutePath.chatSupabase,
        builder: (context, state) => ChatSupabaseScreen(data: state.extra),
      ),


    ];
  }
}
