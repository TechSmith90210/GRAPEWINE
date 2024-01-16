import 'package:flutter/material.dart';

class NavigatorProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void navigatePage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}