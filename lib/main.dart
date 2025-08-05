import 'package:flutter/cupertino.dart';
import 'package:tourism_app/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      theme: const CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
      home: HomeScreen(),
    );
  }
}
