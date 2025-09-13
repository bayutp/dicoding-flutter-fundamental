import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantListProvider(this._apiService);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _emit(RestaurantListLoadingState());

      final result = await _apiService.getRestaurantList();
      if (result.error) {
        _emit(RestaurantListErrorState(result.message));
      } else {
        _emit(RestaurantListLoadedState(result.restaurants));
      }
    } on ClientException catch (_) {
      _emit(RestaurantListErrorState(Helper.errServer));
    } on SocketException catch (_) {
      _emit(RestaurantListErrorState(Helper.errInet));
    } on FormatException catch (_) {
      _emit(RestaurantListErrorState(Helper.errFmt));
    } catch (e) {
      _emit(RestaurantListErrorState(Helper.errMsg));
    }
  }

  void _emit(RestaurantListResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
