import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/liked_songs.dart';
import 'package:grapewine_music_app/models/song_model.dart';

import '../Data/services/local_helper.dart';
import 'musicPlayer_provider.dart';

class LikedProvider with ChangeNotifier {
  // A List to store liked songs
  List<LikedSongs> _likedSongs = [];

  // Getter to access liked songs
  List<LikedSongs> get likedSongs => _likedSongs;

  // Method to check if a song is liked
  bool isLiked(LikedSongs song, {Song? songModel}) {
    if (songModel != null) {
      // Use songModel to check if it's liked
      return _likedSongs.any((likedSong) =>
          likedSong.songName == songModel.songName &&
          likedSong.songArtists == songModel.artists);
    } else {
      // Use the passed song parameter to check if it's liked
      return _likedSongs.any((likedSong) =>
          likedSong.songName == song.songName &&
          likedSong.songArtists == song.songArtists);
    }
  }

  // Method to add a song to liked songs, avoiding duplicates
  void addSongToLiked(LikedSongs song) {
    if (!isLiked(song)) {
      _likedSongs.add(song);
      notifyListeners(); // Notify listeners only if a new song is added

      // Sync with Isar
      LocalHelper().saveLikedSongs(_likedSongs).then(
            (value) => print('synced liked songs with isar'),
          );
    }
  }

  // Method to remove a song from liked songs
  void removeSongFromLiked(LikedSongs song) {
    _likedSongs.removeWhere((likedSong) =>
        likedSong.songName == song.songName &&
        likedSong.songArtists == song.songArtists);
    notifyListeners();
    // Sync with Isar
    LocalHelper().saveLikedSongs(_likedSongs).then(
          (value) => print('synced liked songs with isar'),
        );
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

  // Load liked songs from Isar
  Future<void> loadFromIsar(LocalHelper localHelper) async {
    final songs = await localHelper.loadLikedSongs();

    _likedSongs = songs;
    notifyListeners();

    print('loaded liked songs!');
  }

  // Method to convert liked songs to Song objects and pass to MusicPlayerProvider
  Future<void> playLikedSongs(MusicPlayerProvider musicPlayerProvider,
      SearchProvider provider, RecentlyPlayedProvider recentProvider) async {
    // Convert LikedSongs to Song objects
    List<Song> songPlaylist = _likedSongs.map((likedSong) {
      return Song(
        songName: likedSong.songName,
        imageUrl: likedSong.songImageUrl,
        artists: likedSong.songArtists,
      );
    }).toList();

    songPlaylist = songPlaylist.reversed.toList();

    // Pass the playlist to fetchPlaylist for playback
    await musicPlayerProvider.fetchPlaylist(
        songPlaylist, provider, recentProvider);

    print('playing liked songs right now');
  }

  // Method to play song from any position in liked songs
  Future<void> playLikedSongsAtIndex(
      MusicPlayerProvider musicPlayerProvider,
      int index,
      SearchProvider provider,
      RecentlyPlayedProvider recentProvider) async {
    if (index < 0 || index >= _likedSongs.length) {
      print("Invalid index");
      return;
    }

    // Convert LikedSongs to Song objects
    List<Song> songPlaylist = _likedSongs.map((likedSong) {
      return Song(
        songName: likedSong.songName,
        imageUrl: likedSong.songImageUrl,
        artists: likedSong.songArtists,
      );
    }).toList();

    songPlaylist = songPlaylist.reversed.toList();

    // Pass the playlist and index to fetchPlaylist method
    await musicPlayerProvider
        .fetchPlaylist(songPlaylist, provider, recentProvider, index: index);
  }
}
