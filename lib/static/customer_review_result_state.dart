import 'package:tourism_app/data/model/customer_review.dart';

sealed class CustomerReviewResultState {}

class CustomerReviewNoneState extends CustomerReviewResultState {}

class CustomerReviewLoadingState extends CustomerReviewResultState {}

class CustomerReviewLoadedState extends CustomerReviewResultState {
  final List<CustomerReview> data;

  CustomerReviewLoadedState(this.data);
}

class CustomerReviewErrorState extends CustomerReviewResultState {
  final String error;

  CustomerReviewErrorState(this.error);
}
