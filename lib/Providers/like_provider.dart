import 'package:flutter/foundation.dart';

class LikedProvider with ChangeNotifier {
  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void setLike(newLiked) {
    _isLiked = !_isLiked;
    notifyListeners();
  }
}
