/**
 * Created by Abdullah on 25/8/24.
 */
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static String _REMEMBER_ME_KEY = 'REMEMBER_ME';

  static Future<void> setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_REMEMBER_ME_KEY, value);
  }

  static Future<bool?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_REMEMBER_ME_KEY);
  }

  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_REMEMBER_ME_KEY);
  }
}
