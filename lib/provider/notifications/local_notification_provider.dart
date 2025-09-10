import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tourism_app/service/local_notifications_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationsService localNotificationsService;

  LocalNotificationProvider(this.localNotificationsService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> requestPermissions() async {
    _permission = await localNotificationsService.requestPermissions();
    notifyListeners();
  }

  void showNotifications() {
    _notificationId += 1;
    localNotificationsService.showNotifications(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "rqdv5juczeskfw1e867",
    );
  }

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  void scheduleDailyNotification() {
    _notificationId += 1;
    localNotificationsService.scheduleDailyNotification(id: _notificationId);
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests = await localNotificationsService
        .pendingNotifRequests();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await localNotificationsService.cancelNotification(id);
  }
}
