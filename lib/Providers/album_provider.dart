import 'package:flutter/foundation.dart';
import '../models/album_model.dart';

class AlbumProvider with ChangeNotifier {
  // List to store albums
  List<AlbumModel> _albums = [];

  // Getter to access albums
  List<AlbumModel> get albums => _albums;

  // Method to add an album
  void addAlbum(AlbumModel album) {
    _albums.add(album);
    notifyListeners(); // Notify listeners of the change
  }

  // Method to remove an album by ID
  void removeAlbum(String albumId) {
    _albums.removeWhere((album) => album.id == albumId);
    notifyListeners();
  }

  // Method to update an album
  void updateAlbum(String albumId, AlbumModel updatedAlbum) {
    final index = _albums.indexWhere((album) => album.id == albumId);
    if (index != -1) {
      _albums[index] = updatedAlbum;
      notifyListeners();
    }
  }

  // Method to clear all albums
  void clearAlbums() {
    _albums.clear();
    notifyListeners();
  }

  // Method to fetch an album by ID
  AlbumModel? getAlbumById(String albumId) {
    return _albums.firstWhere((album) => album.id == albumId);
  }

  // Method to replace the current list of albums (useful for batch updates)
  void setAlbums(List<AlbumModel> albumList) {
    _albums = albumList;
    notifyListeners();
  }
}
