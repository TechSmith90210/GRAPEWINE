import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/album_model.dart';

class SearchProvider with ChangeNotifier {
  // Song Details
  String _selectedSongName = 'Unknown Song';
  String get selectedSongName => _selectedSongName;
  void setSongName(String newSongName) {
    _selectedSongName = newSongName;
    notifyListeners();
  }

  String _selectedSongAlbum = 'Unknown Album';
  String get selectedSongAlbum => _selectedSongAlbum;
  void setSongAlbumName(String newAlbumName) {
    _selectedSongAlbum = newAlbumName;
    notifyListeners();
  }

  String _selectedSongArtist = 'Unknown Artist';
  String get selectedSongArtist => _selectedSongArtist;
  void setSongArtist(String newArtist) {
    _selectedSongArtist = newArtist;
    notifyListeners();
  }

  String _selectedSongDetails = '';
  String get selectedSongDetails => _selectedSongDetails;
  void setSongDetails(String newSongDetails) {
    _selectedSongDetails = newSongDetails;
    notifyListeners();
  }

  String _selectedSongImage = 'https://assets.audiomack.com/default-song-image.png';
  String get selectedSongImage => _selectedSongImage;
  void setSongImage(String newSongImage) {
    _selectedSongImage = newSongImage;
    notifyListeners();
  }

  String _selectedSongId = '';
  String get selectedSongId => _selectedSongId;
  void setSongId(String newSongId) {
    _selectedSongId = newSongId;
    notifyListeners();
  }

  // Search Query
  String _query = '';
  String get query => _query;
  void setQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

  // Albums Data: Now using AlbumModel instead of separate lists
  List<AlbumModel> _searchAlbums = [];
  List<AlbumModel> get searchAlbums => _searchAlbums;

  // Method to set albums
  void setAlbums(List<AlbumModel> newAlbums) {
    _searchAlbums = newAlbums;
    notifyListeners();
  }

  // You can still provide getters for individual fields if necessary
  List<String> get searchAlbumNames => _searchAlbums.map((album) => album.name).toList();
  List<String> get searchAlbumImages => _searchAlbums.map((album) => album.imageUrl ?? '').toList();
  List<String> get searchAlbumTypes => _searchAlbums.map((album) => album.type).toList();
  List<String> get searchAlbumArtists => _searchAlbums.map((album) => album.artist).toList();
  List<String> get searchAlbumIds => _searchAlbums.map((album) => album.id).toList();
}
