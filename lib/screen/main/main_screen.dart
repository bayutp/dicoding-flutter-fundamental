import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/screen/main/restaurant_item.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';
import 'package:tourism_app/style/colors/restaurant_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    final provider = context.read<RestaurantListProvider>();
    Future.microtask(() {
      provider.fetchRestaurantList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListLoadedState(data: var restaurants) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find the best restaurants near you...',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox.square(dimension: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30), // radius bulat
                        borderSide: BorderSide.none, // hilangin border garis
                      ),
                    ),
                  ),
                  SizedBox.square(dimension: 32),
                  Text(
                    'Recomended',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(fontSize: 24),
                  ),
                  SizedBox.square(dimension: 16),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant.id,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RestaurantItem(restaurant: restaurant),
                          ),
                        );
                      },
                      itemCount: restaurants.length,
                    ),
                  ),
                ],
              ),
            ),
            RestaurantListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
