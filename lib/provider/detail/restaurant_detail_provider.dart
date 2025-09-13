import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantDetailProvider(this._apiService);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  RestaurantDetailResultState get resultState => _resultState;

  Future<void> getRestaurantDetail(String id) async {
    try {
      _emit(RestaurantDetailLoadingState());

      final result = await _apiService.getRestaurantDetail(id);
      if (result.error) {
        _emit(RestaurantDetailErrorState(result.message));
      } else {
        _emit(RestaurantDetailLoadedState(result.restaurant));
      }
    } on ClientException catch (_) {
      _emit(RestaurantDetailErrorState(Helper.errServer));
    } on SocketException catch (_) {
      _emit(RestaurantDetailErrorState(Helper.errInet));
    } on FormatException catch (_) {
      _emit(RestaurantDetailErrorState(Helper.errFmt));
    } catch (e) {
      _emit(RestaurantDetailErrorState(Helper.errMsg));
    }
  }

  void _emit(RestaurantDetailResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
