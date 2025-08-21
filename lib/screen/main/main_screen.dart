import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/home/restaurant_list_provider.dart';
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(restaurant.name),
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
