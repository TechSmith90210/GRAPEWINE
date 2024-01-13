import 'package:flutter/material.dart';

class PasswordProvider with ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool get obscureText => _obscureText;

  void seePassword() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
