import 'package:flutter/material.dart';
import 'package:tourism_app/model/tourism.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/home/home_screen.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/style/theme/tourism_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Navigationroute.homeRoute.name,
      routes: {Navigationroute.homeRoute.name: (context) => const HomeScreen()},
      onGenerateRoute: (settings) {
        if (settings.name == Navigationroute.detailRoute.name) {
          return MaterialPageRoute(
            builder: (_) =>
                DetailScreen(tourism: settings.arguments as Tourism),
          );
        }
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Route not found'))),
        );
      },
    );
  }
}
