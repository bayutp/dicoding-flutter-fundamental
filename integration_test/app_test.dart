import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/data/local/local_database_service.dart';
import 'package:tourism_app/provider/favorites/local_db_provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/provider/home/search_restaurant_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/provider/notifications/local_notification_provider.dart';
import 'package:tourism_app/provider/notifications/notification_provider.dart';
import 'package:tourism_app/provider/theme/theme_provider.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/service/local_notifications_service.dart';
import 'package:tourism_app/service/shared_preferences_service.dart';

import '../test/provider/home/mock_api.dart';

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });
  testWidgets("tap on the navigation bar menu items", (tester) async {
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<ApiService>(create: (_) => mockApiService),
          Provider(create: (context) => LocalDatabaseService()),
          Provider(create: (context) => SharedPreferencesService(prefs)),
          Provider(
            create: (context) => LocalNotificationsService()
              ..init()
              ..configureLocalTimeZone(),
          ),
          ChangeNotifierProvider(create: (context) => IndexNavProvider()),
          ChangeNotifierProvider(
            create: (context) =>
                RestaurantListProvider(context.read<ApiService>()),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                SearchRestaurantProvider(context.read<ApiService>()),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                LocalDbProvider(context.read<LocalDatabaseService>()),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                ThemeProvider(context.read<SharedPreferencesService>()),
          ),
          ChangeNotifierProvider(
            create: (context) => LocalNotificationProvider(
              context.read<LocalNotificationsService>(),
            )..requestPermissions(),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                NotificationProvider(context.read<SharedPreferencesService>()),
          ),
        ],
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    expect(find.byType(BottomNavigationBar), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.favorite_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.home_rounded));
    await tester.pumpAndSettle();
  });
}
