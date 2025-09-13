import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String _selectedCategory = "foods";

  String get selectedCategory => _selectedCategory;

  set setCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }
}
