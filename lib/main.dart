import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/data/local/local_database_service.dart';
import 'package:tourism_app/data/model/restaurant_detail.dart';
import 'package:tourism_app/provider/detail/category_provider.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/provider/favorites/local_db_provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/provider/home/search_restaurant_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/provider/notifications/local_notification_provider.dart';
import 'package:tourism_app/provider/review/customer_review_provider.dart';
import 'package:tourism_app/provider/theme/theme_provider.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/screen/review/review_screen.dart';
import 'package:tourism_app/service/local_notifications_service.dart';
import 'package:tourism_app/service/shared_preferences_service.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/style/theme/restaurant_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        Provider(create: (context) => SharedPreferencesService(prefs)),
        Provider(create: (context) => LocalDatabaseService()),
        Provider(create: (context) => LocalNotificationsService()..init()),
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
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(context.read<SharedPreferencesService>()),
        ),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(
          create: (context) =>
              LocalDbProvider(context.read<LocalDatabaseService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationsService>(),
          )..requestPermissions(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final provider = context.read<ThemeProvider>();
    Future.microtask(() {
      provider.getTheme();
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: value.settingTheme!.isDark
              ? ThemeMode.dark
              : ThemeMode.light,
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
