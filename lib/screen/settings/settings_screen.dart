import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/setting_notification.dart';
import 'package:tourism_app/data/model/setting_theme.dart';
import 'package:tourism_app/provider/notifications/local_notification_provider.dart';
import 'package:tourism_app/provider/notifications/notification_provider.dart';
import 'package:tourism_app/provider/theme/theme_provider.dart';

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
            await _showNotification();
          } else {
            await _requestPermission();
          }
        }
      });
    });
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
        ],
      ),
    );
  }

  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  Future<void> _showNotification() async {
    context.read<LocalNotificationProvider>().showNotifications();
  }
}
