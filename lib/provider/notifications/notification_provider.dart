import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/model/setting_notification.dart';
import 'package:tourism_app/service/shared_preferences_service.dart';

class NotificationProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  NotificationProvider(this._service);

  String _messaage = "";
  String get message => _messaage;
  
  SettingNotification? _settingNotification;
  SettingNotification? get settingNotification => _settingNotification;
  
  Future<void> setNotificationEnabled(SettingNotification notification) async {
    try {
      await _service.setNotificationEnabled(notification);
      _settingNotification = notification;
      _messaage = notification.notificationEnabled
          ? "Notifications are enabled"
          : "Notifications are disabled";
    } catch (e) {
      _messaage = "Failed to set notification";
    }
    notifyListeners();
  }

  
  void isNotificationEnabled() async {
    try {
      _settingNotification = _service.isNotificationEnabled();
    } catch (e) {
      _messaage = "Failed to retrieve notification";
    }
    notifyListeners();
  }
}