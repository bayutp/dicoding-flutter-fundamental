import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
      child: Center(
        child: CupertinoButton.filled(
          child: Text('Logout'),
          onPressed: () => _openAlert(context),
        ),
      ),
    );
  }

  void _openAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Are you sure to Logout?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: const Text('Yes'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
