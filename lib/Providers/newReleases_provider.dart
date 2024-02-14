import 'package:flutter/foundation.dart';

class NewReleasesProvider with ChangeNotifier {
  //album ids
  List<String?> _albumIds = [];
  List<String?> get albumIds => _albumIds;
  updateIds(List<String?> newAlbumIds) {
    _albumIds = newAlbumIds;
    notifyListeners();
  }

  //album names
  List<String?> _albumNames = [];
  List<String?> get albumNames => _albumNames;
  updateNames(List<String?> newAlbumNames) {
    _albumNames = newAlbumNames;
    notifyListeners();
  }

  // album covers
  List<String?> _albumCovers = [];
  List<String?> get albumCovers => _albumCovers;
  updateCovers(List<String?> newAlbumCovers) {
    _albumCovers = newAlbumCovers;
    notifyListeners();
  }

  // album artists
  List<String?> _albumArtists = [];
  List<String?> get albumArtists => _albumArtists;
  updateArtistNames(List<String?> newAlbumArtists) {
    _albumArtists = newAlbumArtists;
    notifyListeners();
  }
}
