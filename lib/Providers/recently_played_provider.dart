import 'package:flutter/material.dart';
import 'package:grapewine_music_app/models/recently_played.dart';

import '../Data/services/local_helper.dart';

class RecentlyPlayedProvider extends ChangeNotifier {
  // Maximum number of recently played songs
  // static const int maxRecentlyPlayedSongs = 30;

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
    // if (_recentlyPlayedSongs.length >= maxRecentlyPlayedSongs) {
    //   _recentlyPlayedSongs.removeLast();
    // }
    if (isRecentlyPlayed(song)) {
      removeRecentlyPlayed(song);
    }

    _recentlyPlayedSongs.add(song);
    notifyListeners();
    // Sync with Isar
    LocalHelper().saveRecentlyPlayedSongs(_recentlyPlayedSongs).then(
          (value) => print('synced with isar'),
        );
  }

  void removeRecentlyPlayed(RecentlyPlayed song) {
    _recentlyPlayedSongs.remove(song);
    notifyListeners();
    // Sync with Isar
    LocalHelper().saveRecentlyPlayedSongs(_recentlyPlayedSongs).then(
          (value) => print('synced with isar'),
        );
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

  // Method to load recently played songs from Isar and update provider
  Future<void> loadFromIsar(LocalHelper localHelper) async {
    try {
      final songs = await localHelper.loadRecentlyPlayedSongs();
      _recentlyPlayedSongs = songs;
      notifyListeners();
    } catch (e) {
      print("Error loading recently played songs: $e");
    }
  }

  void clearRecentlyPlayed() {
    _recentlyPlayedSongs.clear();
    notifyListeners();
    LocalHelper().saveRecentlyPlayedSongs([]);
  }
}
