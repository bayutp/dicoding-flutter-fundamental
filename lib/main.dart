import 'package:flutter/cupertino.dart';
import 'package:tourism_app/my_route.dart';
import 'package:tourism_app/screen/category_screen.dart';
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
      // home: HomeScreen(),
      initialRoute: MyRoute.home.name,
      routes: {MyRoute.home.name: (context) => const HomeScreen()},
      onGenerateRoute: (settings) {
        if (settings.name == MyRoute.category.name) {
          final args = settings.arguments as String;

          return CupertinoPageRoute(
            builder: (_) => CategoryScreen(selectedCategory: args),
          );
        }

        return CupertinoPageRoute(
          builder: (_) => CupertinoPageScaffold(
            child: Center(child: Text('Route not found')),
          ),
        );
      },
    );
  }
}
