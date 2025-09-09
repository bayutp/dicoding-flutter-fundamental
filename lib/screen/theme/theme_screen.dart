import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/setting_theme.dart';
import 'package:tourism_app/provider/theme/theme_provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  void initState() {
    super.initState();

    final provider = context.read<ThemeProvider>();
    Future.microtask(() {
      provider.getTheme();
      provider.addListener(() {
        if (provider.message.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(provider.message)));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(width: 16),
                Switch(
                  value: provider.settingTheme!.isDark,
                  onChanged: (value) {
                    provider.setTheme(SettingTheme(isDark: value));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
