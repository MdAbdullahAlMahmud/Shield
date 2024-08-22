import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  await dotenv.load(fileName: "assets/.env");
  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['url']!,
    anonKey: dotenv.env['anonKey']!,
  );

  runApp(const App());
}
