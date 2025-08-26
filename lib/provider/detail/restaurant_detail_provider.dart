import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/api/api_service.dart';
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
    } on Exception catch (e) {
      _emit(RestaurantDetailErrorState(e.toString()));
    }
  }

  void _emit(RestaurantDetailResultState state) {
    _resultState = state;
    notifyListeners();
  }
}
