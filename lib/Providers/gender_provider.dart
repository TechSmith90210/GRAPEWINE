import 'package:flutter/material.dart';

class GenderProvider extends ChangeNotifier {
  String _selectedGender = 'Gender';
  var _genders = ['Gender', 'Male', 'Female'];

  String get selectedGender => _selectedGender;
  List<String> get genders => _genders;
  void setGender(String newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }
}
