/**
 * Created by Abdullah on 20/8/24.
 */

enum Flavor {
  DEV,
  UAT,
  PROD,
}

class FlavorConfig {
  bool _lock = false;

  late final Flavor flavor;
  late final String name;
  late final String url;

  static final FlavorConfig instance = FlavorConfig._internal();

  FlavorConfig._internal();

  factory FlavorConfig.instantiate({
    required Flavor flavor,
    required String name,
    required String url,
  }) {
    if (instance._lock) return instance;
    instance._lock = true;
    instance.flavor = flavor;
    instance.name = name;
    instance.url = url;
    return instance;
  }

  static bool isProd() => instance.flavor == Flavor.PROD;

  static bool isDev() => instance.flavor == Flavor.DEV;

  static bool isUAT() => instance.flavor == Flavor.UAT;
}
