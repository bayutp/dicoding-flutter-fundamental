import 'dart:math';

import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/service/local_notifications_service.dart';
import 'package:tourism_app/static/restaurant_workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == RestaurantWorkmanager.oneoff.taskName ||
        task == RestaurantWorkmanager.oneoff.uniqueName ||
        task == Workmanager.iOSBackgroundTask) {
      final httpService = ApiService();
      final result = await httpService.getRestaurantList();
      final data =
          result.restaurants[Random().nextInt(result.restaurants.length)];
      final notifService = LocalNotificationsService();
      await notifService.init();
      await notifService.configureLocalTimeZone();

      await notifService.scheduleDailyNotification(id: 1, restaurant: data);
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? wormanager])
    : _workmanager = wormanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher);
  }

  Future<void> runOneOffTask() async {
    await _workmanager.registerOneOffTask(
      RestaurantWorkmanager.oneoff.uniqueName,
      RestaurantWorkmanager.oneoff.taskName,
      constraints: Constraints(networkType: NetworkType.connected),
      initialDelay: const Duration(seconds: 5),
      inputData: {
        "data": "This is a valid payload from oneoff task workmanager",
      },
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
