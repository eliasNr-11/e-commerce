import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void updateSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}