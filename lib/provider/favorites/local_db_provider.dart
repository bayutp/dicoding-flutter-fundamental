import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/local/local_database_service.dart';
import 'package:tourism_app/data/model/restaurant.dart';

class LocalDbProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDbProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> setFavorites(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
      } else {
        _message = "Your data is saved";
      }
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> loadAllDataFavorites() async {
    try {
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      _message = "All your data is loaded";
    } catch (e) {
      _message = "Failed to load your data";
    }
    notifyListeners();
  }

  Future<void> loadDataFavoritesById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
    } catch (e) {
      _message = "Failed to load your data";
    }
    notifyListeners();
  }

  Future<void> removeFavorites(String id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
    } catch (e) {
      _message = "Failed to remove your data";
    }
    notifyListeners();
  }

  bool checkItemFavorites(String id) {
    final isFavorites = _restaurant?.id == id;
    return isFavorites;
  }
}
