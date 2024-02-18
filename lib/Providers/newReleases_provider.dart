import 'package:flutter/foundation.dart';

class NewReleasesProvider with ChangeNotifier {
  //album ids
  List<String> _albumIds = [
    "0kXRXezhirr0900HvfPYHV?si=4AoLI3c-SfC5V6rZnqWBhA",
    "2pOEFqvfxp5uUQ8vQEmVA0?si=yiGEzM3CTnquDYaxecaq7g",
    "007DWn799UWvfY1wwZeENR?si=yJZDbW66Qry3NWpKU1OZbA",
    "4Q7cRXio6mF2ImVUCcezPO?si=LLwY7fj3Rtya1hRwaYqEXQ",
    "41GuZcammIkupMPKH2OJ6I?si=qm_zJYIMRtG7rQhSP10ATg",
    "5YvgvpgACOjrJHe7LFqJhc?si=KjemO7bGSaeC3B-LDkcyWA"
  ];
  List<String> get albumIds => _albumIds;
  updateIds(List<String> newAlbumIds) {
    _albumIds = newAlbumIds;
    notifyListeners();
  }

  //album names
  List<String> _albumNames = [
    "At The Party",
    "Heaven Knows",
    "I Am > I Was",
    "For All the Dogs Scary Hours Edition",
    "ASTROWORLD",
    "NO ONE'S NICE TO ME"
  ];

  List<String> get albumNames => _albumNames;
  updateNames(List<String> newAlbumNames) {
    _albumNames = newAlbumNames;
    notifyListeners();
  }

  // album covers
  List<String> _albumCovers = [
    "https://i.scdn.co/image/ab67616d0000b273581f1908ffdfef41ca3ce7f4",
    "https://i.scdn.co/image/ab67616d0000b27312e36c27d935e955b44c6581",
    "https://i.scdn.co/image/ab67616d0000b273280689ecc5e4b2038bb5e4bd",
    "https://i.scdn.co/image/ab67616d0000b273e286ee36b4015afa8832356a",
    "https://i.scdn.co/image/ab67616d0000b273072e9faef2ef7b6db63834a3",
    "https://i.scdn.co/image/ab67616d0000b273bc31929a3985a653d08e16c6"
  ];
  List<String> get albumCovers => _albumCovers;
  updateCovers(List<String> newAlbumCovers) {
    _albumCovers = newAlbumCovers;
    notifyListeners();
  }

  // album artists
  List<String> _albumArtists = [
    "Kid Cudi, Pharell Williams, Travis Scott",
    "Pink Panthress",
    "21 Savage",
    "Drake",
    "Travis Scott",
    "Cochise"
  ];
  List<String> get albumArtists => _albumArtists;
  updateArtistNames(List<String> newAlbumArtists) {
    _albumArtists = newAlbumArtists;
    notifyListeners();
  }

  //getting index
  int _index = 0;
  int get index => _index;
  void updateIndex(int newIndex) {
    _index = newIndex;
  }
}
