import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism_app/data/model/setting_notification.dart';
import 'package:tourism_app/data/model/setting_theme.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String _keyTheme = "MYTHEME";
  static const String _keyNotification = "MYNOTIFICATION";

  Future<void> setTheme(SettingTheme theme) async {
    try {
      await _preferences.setBool(_keyTheme, theme.isDark);
    } catch (e) {
      throw Exception("Shared preferences cannot save the theme");
    }
  }

  Future<void> setNotificationEnabled(SettingNotification value) async {
    try {
      await _preferences.setBool(_keyNotification, value.notificationEnabled);
    } catch (e) {
      throw Exception("Shared preferences cannot set notification");
    }
  }

  SettingTheme getTheme() {
    return SettingTheme(isDark: _preferences.getBool(_keyTheme) ?? false);
  }

  SettingNotification isNotificationEnabled() {
    return SettingNotification(
      notificationEnabled: _preferences.getBool(_keyNotification) ?? false,
    );
  }
}
