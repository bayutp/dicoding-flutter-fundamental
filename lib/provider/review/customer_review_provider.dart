import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/static/customer_review_result_state.dart';
import 'package:tourism_app/static/helper.dart';

class CustomerReviewProvider extends ChangeNotifier {
  final ApiService _apiService;

  CustomerReviewProvider(this._apiService);

  CustomerReviewResultState _resultState = CustomerReviewNoneState();

  CustomerReviewResultState get resultState => _resultState;

  Future<void> addReview(String id, String name, String review) async {
    try {
      _emit(CustomerReviewLoadingState());

      final result = await _apiService.addReview(id, name, review);
      if (result.error) {
        _emit(CustomerReviewErrorState(result.message));
      } else {
        _emit(CustomerReviewLoadedState(result.customerReviews));
      }
    } on ClientException catch (_) {
      _emit(CustomerReviewErrorState(Helper.errServer));
    } on SocketException catch (_) {
      _emit(CustomerReviewErrorState(Helper.errInet));
    } on FormatException catch (_) {
      _emit(CustomerReviewErrorState(Helper.errFmt));
    } catch (e) {
      _emit(CustomerReviewErrorState(Helper.errMsg));
    }
  }

  void _emit(CustomerReviewResultState state) {
    _resultState = state;
    notifyListeners();
  }

  void resetState() {
    _resultState = CustomerReviewNoneState();
    notifyListeners();
  }
}
