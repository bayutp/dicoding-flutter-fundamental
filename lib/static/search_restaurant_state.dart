import 'package:tourism_app/data/model/restaurant.dart';

sealed class SearchRestaurantState {}

class SearchRestaurantNoneState extends SearchRestaurantState {}

class SearchRestaurantLoadingState extends SearchRestaurantState {}

class SearchRestaurantErrorState extends SearchRestaurantState {
  final String error;

  SearchRestaurantErrorState(this.error);
}

class SearchRestaurantLoadedState extends SearchRestaurantState {
  List<Restaurant> data;

  SearchRestaurantLoadedState(this.data);
}
