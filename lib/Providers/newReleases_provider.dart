import 'package:flutter/foundation.dart';

class NewReleasesProvider with ChangeNotifier {
  List<String> albumIds = [];
  List<String> albumNames = [];
  List<List<String?>> allAlbumArtists = [];
  List<String?> albumCovers = [];
  List<String?> albumTypes = [];

  // Method to update the album data
  void updateNewReleasesData(List<String> ids, List<String> names,
      List<List<String?>> artists, List<String?> covers, List<String?> types) {
    albumIds = ids;
    albumNames = names;
    allAlbumArtists = artists;
    albumCovers = covers;
    albumTypes = types;

    // Notify listeners so that widgets can rebuild with the new data
    notifyListeners();
  }

  // Getter methods to access the updated data:
  List<String> get getAlbumIds => albumIds;
  List<String> get getAlbumNames => albumNames;
  List<List<String?>> get getAllAlbumArtists => allAlbumArtists;
  List<String?> get getAlbumCovers => albumCovers;
  List<String?> get getAlbumTypes => albumTypes;  // Getter for albumTypes
}
