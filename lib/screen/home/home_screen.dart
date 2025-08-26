import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/screen/home/restaurant_item.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    'Recomended Restaurant',
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
