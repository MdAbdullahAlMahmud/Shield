import 'flavor_config.dart';

class AppProperties {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Shield App Dev';
      case Flavor.UAT:
        return 'Shield App Uat';
      case Flavor.PROD:
        return 'Shield App prod';
      default:
        return 'title';
    }
  }

}
