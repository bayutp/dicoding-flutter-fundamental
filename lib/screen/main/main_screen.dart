import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    final provider = context.read<RestaurantListProvider>();
    Future.microtask((){
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
            RestaurantListLoadedState(data: var restaurants) =>
              ListView.builder(
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, NavigationRoute.detailRoute.name, arguments: restaurant.id),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(restaurant.name, style: TextStyle(fontSize: 16),),
                    ),
                  );
                },
                itemCount: restaurants.length,
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
