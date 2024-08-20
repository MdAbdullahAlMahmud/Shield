import 'package:flutter/cupertino.dart';

import 'app.dart';
import 'core/di/di_setup.dart';
import 'flavors/app_properties.dart';
import 'flavors/flavor_config.dart';

Future<void> main() async {
  AppProperties.appFlavor = Flavor.DEV;

  FlavorConfig.instantiate(
      flavor: Flavor.DEV,
      name: "Shield App Dev",
      url: "https://dev.example.com"
  );

  setupDependencies();
  runApp(const App());
}
