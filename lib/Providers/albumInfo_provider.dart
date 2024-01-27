import 'package:flutter/foundation.dart';

class AlbumInfoProvider with ChangeNotifier {
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
}
