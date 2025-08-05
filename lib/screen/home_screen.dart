import 'package:flutter/cupertino.dart';
import 'package:tourism_app/screen/feeds_screen.dart';
import 'package:tourism_app/screen/search_screen.dart';
import 'package:tourism_app/screen/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return switch (index) {
          1 => const SearchScreen(),
          2 => const SettingsScreen(),
          _ => const FeedsScreen(),
        };
      },
    );
  }
}
