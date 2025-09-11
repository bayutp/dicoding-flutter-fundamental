import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/setting_notification.dart';
import 'package:tourism_app/data/model/setting_theme.dart';
import 'package:tourism_app/provider/notifications/local_notification_provider.dart';
import 'package:tourism_app/provider/notifications/notification_provider.dart';
import 'package:tourism_app/provider/notifications/payload_provider.dart';
import 'package:tourism_app/provider/theme/theme_provider.dart';
import 'package:tourism_app/service/local_notifications_service.dart';
import 'package:tourism_app/static/navigation_route.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    final provider = context.read<ThemeProvider>();
    final localNotifProvider = context.read<LocalNotificationProvider>();
    final notifProvider = context.read<NotificationProvider>();

    _configureSelectNotificationSubject();

    Future.microtask(() {
      provider.getTheme();
      provider.addListener(() {
        if (provider.message.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(provider.message)));
        }
      });

      notifProvider.isNotificationEnabled();
      notifProvider.addListener(() async {
        if (notifProvider.message.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(notifProvider.message)));
        }

        if (notifProvider.settingNotification?.notificationEnabled == true) {
          final granted = localNotifProvider.permission;
          if (granted == true) {
            await _scheduleDailyNotification();
          } else {
            await _requestPermission();
          }
        } else {
          //cancel notif
          _cancelNotification();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 16),
                  Switch(
                    value: provider.settingTheme?.isDark ?? false,
                    onChanged: (value) {
                      provider.setTheme(SettingTheme(isDark: value));
                    },
                  ),
                ],
              );
            },
          ),
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Notification',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 16),
                  Switch(
                    value:
                        provider.settingNotification?.notificationEnabled ??
                        false,
                    onChanged: (value) {
                      provider.setNotificationEnabled(
                        SettingNotification(notificationEnabled: value),
                      );
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox.square(dimension: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     _checkPendingNotificationRequests();
          //   },
          //   child: Text('Notifications'),
          // ),
        ],
      ),
    );
  }

  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      if (mounted) {
        context.read<PayloadProvider>().payload = payload;
        payload == null
            ? Navigator.pushNamed(context, NavigationRoute.mainRoute.name)
            : Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: payload,
              );
      }
    });
  }

  Future<void> _scheduleDailyNotification() async {
    context.read<LocalNotificationProvider>().scheduleDailyNotification();
  }

  Future<void> _cancelNotification() async {
    final localnotifProvider = context.read<LocalNotificationProvider>();
    await localnotifProvider.checkPendingNotificationRequests(context);
    if (!mounted) {
      return;
    }
    final data = localnotifProvider.pendingNotificationRequests;
    if (data.isNotEmpty) {
      localnotifProvider
        ..cancelNotification(data.first.id)
        ..checkPendingNotificationRequests(context);
    }
  }

  // Future<void> _checkPendingNotificationRequests() async {
  //   final localNotificationProvider = context.read<LocalNotificationProvider>();
  //   await localNotificationProvider.checkPendingNotificationRequests(context);

  //   if (!mounted) {
  //     return;
  //   }

  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       final pendingData = context.select(
  //         (LocalNotificationProvider provider) =>
  //             provider.pendingNotificationRequests,
  //       );
  //       return AlertDialog(
  //         title: Text(
  //           '${pendingData.length} pending notification requests',
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         content: SizedBox(
  //           height: 300,
  //           width: 300,
  //           child: ListView.builder(
  //             itemCount: pendingData.length,
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) {
  //               // todo-03-action-05: iterate a listtile
  //               final item = pendingData[index];
  //               return ListTile(
  //                 title: Text(
  //                   item.title ?? "",
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //                 subtitle: Text(
  //                   item.body ?? "",
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //                 contentPadding: EdgeInsets.zero,
  //                 trailing: IconButton(
  //                   onPressed: () {
  //                     localNotificationProvider
  //                       ..cancelNotification(item.id)
  //                       ..checkPendingNotificationRequests(context);
  //                   },
  //                   icon: const Icon(Icons.delete_outline),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
