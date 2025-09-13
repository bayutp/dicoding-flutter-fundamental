import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/restaurant.dart';
import 'package:tourism_app/provider/detail/favorites_icon_provider.dart';
import 'package:tourism_app/provider/favorites/local_db_provider.dart';

class FavoritesIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoritesIconWidget({super.key, required this.restaurant});

  @override
  State<FavoritesIconWidget> createState() => _FavoritesIconWidgetState();
}

class _FavoritesIconWidgetState extends State<FavoritesIconWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final localDbProvider = context.read<LocalDbProvider>();
      final favoritesIconProvider = context.read<FavoritesIconProvider>();
      
      await localDbProvider.loadDataFavoritesById(widget.restaurant.id);
      final isFavorites = localDbProvider.checkItemFavorites(
        widget.restaurant.id,
      );
      favoritesIconProvider.setFavorites = isFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDbProvider = context.read<LocalDbProvider>();
        final favoritesIconProvider = context.read<FavoritesIconProvider>();
        final isFavorites = favoritesIconProvider.isFavorites;

        if (isFavorites) {
          await localDbProvider.removeFavorites(widget.restaurant.id);
        } else {
          await localDbProvider.setFavorites(widget.restaurant);
        }
        favoritesIconProvider.setFavorites = !isFavorites;
        localDbProvider.loadAllDataFavorites();
      },
      icon: Icon(
        context.watch<FavoritesIconProvider>().isFavorites
            ? Icons.favorite_rounded
            : Icons.favorite_outline_rounded,
      ),
    );
  }
}
