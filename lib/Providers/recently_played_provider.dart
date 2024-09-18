import 'package:flutter/material.dart';
import 'package:grapewine_music_app/models/recently_played.dart';

class RecentlyPlayedProvider extends ChangeNotifier {
  // Maximum number of recently played songs
  static const int maxRecentlyPlayedSongs = 10;

  List<RecentlyPlayed> _recentlyPlayedSongs = [];

  // Getter to access liked songs
  List<RecentlyPlayed> get recentlyPlayedSongs => _recentlyPlayedSongs;

  // Method to check if a song is liked
  bool isRecentlyPlayed(RecentlyPlayed song) {
    return _recentlyPlayedSongs.any((recentSong) =>
        recentSong.songName == song.songName &&
        recentSong.songArtists == song.songArtists);
  }

  void addRecentlyPlayed(RecentlyPlayed song) {
    if (_recentlyPlayedSongs.length >= maxRecentlyPlayedSongs) {
      _recentlyPlayedSongs.removeLast();
    }
    if(isRecentlyPlayed(song)){
      removeRecentlyPlayed(song);
    }

    _recentlyPlayedSongs.add(song);
    notifyListeners();
  }

  void removeRecentlyPlayed(RecentlyPlayed song) {
    _recentlyPlayedSongs.remove(song);
    notifyListeners();
  }

  void toggleRecentlyPlayed(RecentlyPlayed song) {
    if (isRecentlyPlayed(song)) {
      removeRecentlyPlayed(song);
      addRecentlyPlayed(song);
    } else {
      addRecentlyPlayed(song);
    }
    notifyListeners();
  }
}
