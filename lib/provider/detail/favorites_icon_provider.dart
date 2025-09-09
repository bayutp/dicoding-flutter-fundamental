import 'package:flutter/material.dart';

class FavoritesIconProvider extends ChangeNotifier {
  bool _isFavorites = false;

  bool get isFavorites => _isFavorites;

  set setFavorites(bool value) {
    _isFavorites = value;
    notifyListeners();
  }
}
