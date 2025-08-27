import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/data/model/restaurant_detail.dart';
import 'package:tourism_app/provider/detail/category_provider.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/provider/home/search_restaurant_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/provider/review/customer_review_provider.dart';
import 'package:tourism_app/provider/theme/theme_provider.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/screen/review/review_screen.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/style/theme/restaurant_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchRestaurantProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              CustomerReviewProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
            NavigationRoute.reviewRoute.name: (context) => ReviewScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments
                      as RestaurantDetail,
            ),
          },
        );
      },
    );
  }
}
