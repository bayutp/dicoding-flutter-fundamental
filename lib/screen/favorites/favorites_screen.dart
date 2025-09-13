import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/favorites/local_db_provider.dart';
import 'package:tourism_app/screen/home/restaurant_item.dart';
import 'package:tourism_app/static/navigation_route.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    final provider = context.read<LocalDbProvider>();
    Future.microtask(() {
      provider.loadAllDataFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocalDbProvider>(
        builder: (context, value, child) {
          final favoritesList = value.restaurantList ?? [];
          if (favoritesList.isEmpty) {
            return Center(child: Text('Data Favorites is empty!'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final restaurant = favoritesList[index];
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
                      itemCount: favoritesList.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
