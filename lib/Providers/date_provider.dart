import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  DateTime? _selectedDate;

  DateProvider({DateTime? initialDate}) : _selectedDate = initialDate;

  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime? newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}
