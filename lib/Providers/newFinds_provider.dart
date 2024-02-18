import 'package:flutter/foundation.dart';

class NewFindsProvider with ChangeNotifier {
  //album ids
  List<String> _albumIds = [];
  List<String> get albumIds => _albumIds;
  updateIds(List<String> newAlbumIds) {
    _albumIds = newAlbumIds;
    notifyListeners();
  }

  //album names
  List<String> _albumNames = [
    "Because the Internet",
    "Alone at Prom (deluxe)",
    "Eternal Atake (Deluxe) - LUV vs. The World 2",
    "My Bloody America",
    "All is Yellow",
    "Die Lit",
    "DOA"
  ];

  List<String> get albumNames => _albumNames;
  updateNames(List<String> newAlbumNames) {
    _albumNames = newAlbumNames;
    notifyListeners();
  }

  // album covers
  List<String> _albumCovers = [
    // because the internet
    "https://i.scdn.co/image/ab67616d0000b27326d64b6150aa3d9b6b67d857",

    //alone at prom (deluxe)
    "https://i.scdn.co/image/ab67616d0000b2734048d1ba8aa549c822504e03",

    //eternal atake
    "https://i.scdn.co/image/ab67616d0000b273dea510881ec1e506485303e4",

    // my bloody america
    "https://i.scdn.co/image/ab67616d0000b273f1e5a9b21eddb3c7ce8b4319",

    //All is Yellow
    "https://i.scdn.co/image/ab67616d0000b2733011c33da8122f277da3b0e5",
    //Die Lit
    "https://i.scdn.co/image/ab67616d0000b273a1e867d40e7bb29ced5c0194",
    //Doa
    "https://i.scdn.co/image/ab67616d0000b2731c615ec4f5dd17806a802162"
  ];
  List<String> get albumCovers => _albumCovers;
  updateCovers(List<String> newAlbumCovers) {
    _albumCovers = newAlbumCovers;
    notifyListeners();
  }

  // album artists
  List<String> _albumArtists = [
    "Childish Gambino",
    "Tory Lanez",
    "Lil Uzi Vert",
    "City Morgue, Zillakami & Sosmula",
    "Lyrical Lemonade",
    "Playboi Carti",
    "ericdoa",
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
