import 'package:flutter/foundation.dart';

class AlbumInfoProvider with ChangeNotifier {
  static const albumIds = [
    //diamond eyes
    '1GjjBpY2iDwSQs5bykQI5e?si=P--e3obzQvGRW0xd284uvg',

    // 5th AMNDMNT
    '5IJAhCl93xn2Ybqk8OGm6n?si=if_ooLW9TEar8VuCBWc5iQ',

    // Come Over when you're sober pt 2
    '52JymrguPgkmmwLaWIusst?si=VXifyNBVSr-txNmpaiMGsQ',

    // MM...FOOD
    '1UcS2nqUhxrZjrBZ3tHk2N?si=yrLU11b4QU2kjFORbSV4Cw',

    // ANTI(DELUXE)
    '4UlGauD7ROb3YbVOFMgW5u?si=n3JEUQqnThSju7IB7-5evw',

    // Cilvia Demo
    '6JF49ixyHmOgS0Rsda2k42?si=_v5kT_7QQsOcXHzOcLLLqg'
  ];
  static const albumIds2 = [
    //
  ];
  //artist Names with setter methods
  List<String> _artistNamesProviders = [];
  List<String> get artistNamesProviders => _artistNamesProviders;
  void updateArtistNames(List<String> newArtistNames) {
    _artistNamesProviders = newArtistNames;
    notifyListeners();
  }

  //album Names with setter Method
  List<String> _albumNamesProviders = [];
  List<String> get albumNamesProviders => _albumNamesProviders;
  void updateAlbumNames(List<String> newAlbumNames) {
    _albumNamesProviders = newAlbumNames;
    notifyListeners();
  }

  //album Covers with setter Method
  List<String> _albumCoversProviders = [];
  List<String> get albumCoversProviders => _albumCoversProviders;
  void updateAlbumCovers(List<String> newAlbumCovers) {
    _albumCoversProviders = newAlbumCovers;
    notifyListeners();
  }

  int _index = 0;
  int get index => _index;
  void updateIndex(int newIndex) {
    // _index=newIndex;
    newIndex + 1;
    notifyListeners();
  }
}
