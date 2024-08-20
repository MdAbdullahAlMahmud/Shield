import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shield/router/app_router.dart';
import 'flavors/app_properties.dart';

void main() {
  runApp(const App());
}
class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppProperties.title,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,

    );
  }
}
