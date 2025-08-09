import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/model/tourism.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/style/theme/tourism_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IndexNavProvider(),
      child: const MyApp(),
    ),
  );
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
      initialRoute: Navigationroute.mainRoute.name,
      routes: {
        Navigationroute.mainRoute.name: (context) => const MainScreen(),
        Navigationroute.detailRoute.name: (context) => DetailScreen(
          tourism: ModalRoute.of(context)?.settings.arguments as Tourism,
        ),
      },
    );
  }
}
