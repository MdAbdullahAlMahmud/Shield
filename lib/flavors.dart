enum Flavor {
  dev,
  uat,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Shield App Dev';
      case Flavor.uat:
        return 'Shield App Uat';
      case Flavor.prod:
        return 'Shield App prod';
      default:
        return 'title';
    }
  }

}
