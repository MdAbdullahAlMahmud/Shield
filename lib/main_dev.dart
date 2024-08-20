import 'package:flutter/cupertino.dart';
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

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://tbngqxyijhtywlcgatas.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRibmdxeHlpamh0eXdsY2dhdGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQxNTQ2MDcsImV4cCI6MjAzOTczMDYwN30.d10dq_67KfvpjrQNDIhgRBmbgiDOhd4-fJtWeH4oPGU',
  );

  runApp(const App());
}
