import 'package:tourism_app/data/model/tourism.dart';

sealed class TourismDetailResultState {}

class TourismDetailNoneState extends TourismDetailResultState {}

class TourismDetailLoadingState extends TourismDetailResultState {}

class ToursimDetailErrorState extends TourismDetailResultState {
  final String error;

  ToursimDetailErrorState(this.error);
}

class TourismDetailLoadedState extends TourismDetailResultState {
  final Tourism data;

  TourismDetailLoadedState(this.data);
}
