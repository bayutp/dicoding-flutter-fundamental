import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism_app/data/model/setting_theme.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyTheme = "MYTHEME";

  Future<void> setTheme(SettingTheme theme) async {
    try {
      await _preferences.setBool(_keyTheme, theme.isDark);
    } catch (e) {
      throw Exception("Shared preferences cannot save the theme");
    }
  }

  SettingTheme getTheme() {
    return SettingTheme(isDark: _preferences.getBool(_keyTheme) ?? false);
  }
}
