import 'package:flutter/foundation.dart';

class AccessTokenProvider with ChangeNotifier {
  String _accessToken = '';
  String get accessToken => _accessToken;

  saveAccessToken(String newAccessToken) {
    _accessToken = newAccessToken;
    notifyListeners();
  }

}
