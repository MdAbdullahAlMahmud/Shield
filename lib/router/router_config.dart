import 'package:go_router/go_router.dart';
import 'package:shield/core/services/navigator/app_navigator_service.dart';

/**
 * Created by Abdullah on 21/8/24.
 */

GoRouter routerConfig({routesList}) {
  return GoRouter(
      routes: routesList,
      navigatorKey: AppNavigatorService.navigatorKey,
      initialLocation: '/'
  );
}