import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/home/search_restaurant_provider.dart';
import 'package:tourism_app/screen/home/restaurant_item.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/static/search_restaurant_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    final provider = context.read<SearchRestaurantProvider>();
    Future.microtask(() {
      provider.searchRestaurants('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String qurey = "";
    return Scaffold(
      body: Consumer<SearchRestaurantProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            SearchRestaurantLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            SearchRestaurantLoadedState(data: var restaurants) => Padding(
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
                    onSubmitted: (value) {
                      qurey = value;
                      final searchProvider = context
                          .read<SearchRestaurantProvider>();
                      if (qurey.isNotEmpty) {
                        Future.microtask(() {
                          searchProvider.searchRestaurants(qurey);
                        });
                      }
                    },
                  ),
                  SizedBox.square(dimension: 32),
                  Text(
                    qurey.isEmpty ? 'Recomended' : 'Search for \'$qurey\'',
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
            SearchRestaurantErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
