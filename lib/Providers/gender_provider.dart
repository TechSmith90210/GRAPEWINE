import 'package:flutter/foundation.dart';

class GenderProvider extends ChangeNotifier {
  String _gender = "Gender";
  var _genders = ['Gender', 'Male', 'Female'];
  String get gender => _gender;
  List<String> get genders => _genders;

  void setGender(String newGender) {
    _gender = newGender;
    notifyListeners();
  }
}
