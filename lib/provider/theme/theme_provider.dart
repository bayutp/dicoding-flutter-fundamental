import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/model/setting_theme.dart';
import 'package:tourism_app/service/shared_preferences_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  ThemeProvider(this._service);

  String _messaage = "";
  String get message => _messaage;

  SettingTheme? _settingTheme;
  SettingTheme? get settingTheme => _settingTheme;

  Future<void> setTheme(SettingTheme theme) async {
    try {
      await _service.setTheme(theme);
      _messaage = "New theme applied";
    } catch (e) {
      _messaage = "Failed to change theme";
    }
    notifyListeners();
  }

  void getTheme() async {
    try {
      _settingTheme = _service.getTheme();
      _messaage = "Theme loaded successfully";
    } catch (e) {
      _messaage = "Failed to retrieve current theme";
    }
    notifyListeners();
  }
}
