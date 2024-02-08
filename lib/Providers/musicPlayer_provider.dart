import 'package:flutter/material.dart';

class MusicPlayerProvider with ChangeNotifier {
  bool _isLyrics = false;
  bool get isLyrics => _isLyrics;

  void showLyrics() {
    _isLyrics = !_isLyrics;
    notifyListeners();
  }

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void likeSong() {
    _isLiked = !_isLiked;
    notifyListeners();
  }

  bool _isPlayed = false;
  bool get isPlayed => _isPlayed;

  void playSong() {
    _isPlayed = !_isPlayed;
    notifyListeners();
  }

  List<String> _artistImages = [
    // Cudi
    'https://i.scdn.co/image/ab6761610000e5eb876faa285687786c3d314ae0',
    //pharell
    'https://i.scdn.co/image/ab6761610000e5ebf0789cd783c20985ec3deb4e',
    //travis
    'https://i.scdn.co/image/ab6761610000e5eb19c2790744c792d05570bb71',
  ];
  List<String> get artistImages => _artistImages;

  List<String> _artistNames = ['Kid Cudi', 'Pharrell Williams', 'Travis Scott'];
  List<String> get artistNames => _artistNames;

  double _value = 2.0;
  double get value => _value;

  void setVolume(double newVolume){
    _value=newVolume;
    notifyListeners();
  }
}
