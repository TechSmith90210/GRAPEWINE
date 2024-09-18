import 'package:flutter/material.dart';
import 'package:grapewine_music_app/models/liked_songs.dart';

class LikedProvider with ChangeNotifier {
  // A List to store liked songs
  List<LikedSongs> _likedSongs = [];

  // Getter to access liked songs
  List<LikedSongs> get likedSongs => _likedSongs;

  // Method to check if a song is liked
  bool isLiked(LikedSongs song) {
    return _likedSongs.any((likedSong) =>
        likedSong.songName == song.songName &&
        likedSong.songArtists == song.songArtists);
  }

  // Method to add a song to liked songs, avoiding duplicates
  void addSongToLiked(LikedSongs song) {
    if (!isLiked(song)) {
      _likedSongs.add(song);
      notifyListeners(); // Notify listeners only if a new song is added
    }
  }

  // Method to remove a song from liked songs
  void removeSongFromLiked(LikedSongs song) {
    _likedSongs.removeWhere((likedSong) =>
        likedSong.songName == song.songName &&
        likedSong.songArtists == song.songArtists);
    notifyListeners();
  }

  void toggleLike(LikedSongs song) {

    if (isLiked(song)) {
      // Remove song from liked songs
      removeSongFromLiked(song); // Update in-memory state
    } else {
      // Add song to liked songs
      addSongToLiked(song); // Update in-memory state
    }
    notifyListeners();
  }

  // Clear all liked songs (optional)
  void clearLikedSongs() {
    _likedSongs.clear();
    notifyListeners();
  }
}
