import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/data/model/restaurant.dart';
import 'package:tourism_app/data/model/restaurant_list_response.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';

import 'package:tourism_app/screen/main/main_screen.dart';

import 'provider/home/mock_api.dart';

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  testWidgets('Check every component on first look of MyApp', (
    WidgetTester tester,
  ) async {
    when(() => mockApiService.getRestaurantList()).thenAnswer(
      (_) async => RestaurantListResponse(
        error: false,
        message: "success",
        count: 1,
        restaurants: [
          Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description: "Test desc",
            pictureId: "14",
            city: "Gorontalo",
            rating: 4,
          ),
        ],
      ),
    );

    await mockNetworkImages(() async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<ApiService>(create: (_) => mockApiService),
            ChangeNotifierProvider(create: (context) => IndexNavProvider()),
            ChangeNotifierProvider(
              create: (context) =>
                  RestaurantListProvider(context.read<ApiService>()),
            ),
          ],
          child: const MaterialApp(home: MainScreen()),
        ),
      );

      // checking app bar component
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text("Restaurant App"), findsOneWidget);

      // checking bottom nav bar component
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byIcon(Icons.home_rounded), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);

      // checking list view component
      await tester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text("Melting Pot"), findsOneWidget);

      verify(() => mockApiService.getRestaurantList()).called(1);
    });
  });
}
