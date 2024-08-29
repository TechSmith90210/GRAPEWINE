import 'package:flutter/material.dart';
import '../models/song_model.dart';

class LikedProvider with ChangeNotifier {
  // A List to store liked songs
  List<Song> _likedSongs = [];

  // Getter to access liked songs
  List<Song> get likedSongs => _likedSongs;

  // Method to check if a song is liked
  bool isLiked(Song song) {
    return _likedSongs.any((likedSong) =>
        likedSong.songName == song.songName &&
        likedSong.artists == song.artists);
  }

  // Method to add a song to liked songs, avoiding duplicates
  void addSongToLiked(Song song) {
    if (!isLiked(song)) {
      _likedSongs.add(song);
      notifyListeners(); // Notify listeners only if a new song is added
    }
  }

  // Method to remove a song from liked songs
  void removeSongFromLiked(Song song) {
    _likedSongs.removeWhere((likedSong) =>
        likedSong.songName == song.songName &&
        likedSong.artists == song.artists);
    notifyListeners();
  }

  // Method to toggle the like status of a song
  void toggleLike(Song song) {
    if (isLiked(song)) {
      removeSongFromLiked(song);
    } else {
      addSongToLiked(song);
    }
  }

  // Clear all liked songs (optional)
  void clearLikedSongs() {
    _likedSongs.clear();
    notifyListeners();
  }
}
