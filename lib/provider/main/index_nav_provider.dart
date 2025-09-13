import 'package:flutter/widgets.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNav = 0;

  int get indexBottomNav => _indexBottomNav;

  set setIndexBottomNav(int index) {
    _indexBottomNav = index;
    notifyListeners();
  }
}
