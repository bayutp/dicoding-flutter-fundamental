import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/static/search_restaurant_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService _apiService;

  SearchRestaurantProvider(this._apiService);

  SearchRestaurantState _resultState = SearchRestaurantNoneState();

  SearchRestaurantState get resultState => _resultState;

  Future<void> searchRestaurants(String query) async {
    try {
      _emit(SearchRestaurantLoadingState());

      final result = await _apiService.searchRestaurants(query);
      if (result.error) {
        _emit(SearchRestaurantErrorState("Terjadi kesalahan"));
      } else {
        _emit(SearchRestaurantLoadedState(result.restaurants));
      }
    } on ClientException catch (_) {
      _emit(SearchRestaurantErrorState(Helper.errServer));
    } on SocketException catch (_) {
      _emit(SearchRestaurantErrorState(Helper.errInet));
    } on FormatException catch (_) {
      _emit(SearchRestaurantErrorState(Helper.errFmt));
    } catch (e) {
      _emit(SearchRestaurantErrorState(Helper.errMsg));
    }
  }

  void _emit(SearchRestaurantState state) {
    _resultState = state;
    notifyListeners();
  }
}
