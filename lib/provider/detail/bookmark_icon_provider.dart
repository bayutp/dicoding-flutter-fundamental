import 'package:flutter/foundation.dart';

class BookmarkIconProvider extends ChangeNotifier {
  bool _isBookmarked = false;

  bool get isBookmarked => _isBookmarked;

  set isBookmarked(bool value) {
    _isBookmarked = value;
    notifyListeners();
  }
}
