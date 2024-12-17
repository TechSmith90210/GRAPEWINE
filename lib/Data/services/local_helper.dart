import 'package:flutter/material.dart';
import 'package:grapewine_music_app/models/liked_songs.dart';
import 'package:grapewine_music_app/models/recently_played.dart';
import 'package:grapewine_music_app/models/playlist.dart'; // Import Playlist model
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalHelper extends ChangeNotifier {
  LocalHelper._internal();

  // Singleton instance for efficiency
  static final LocalHelper _instance = LocalHelper._internal();

  factory LocalHelper() => _instance;

  late final Isar _isar;

  // Initialize Isar database
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        LikedSongsSchema,
        RecentlyPlayedSchema,
        PlaylistSchema,
        PlaylistSongSchema
      ],
      directory: dir.path,
    );
  }

  // ===================== Recently Played Methods ======================

  Future<List<RecentlyPlayed>> loadRecentlyPlayedSongs() async {
    try {
      return await _isar.recentlyPlayeds.where().sortByPlayedAt().findAll();
    } catch (e) {
      print("Error loading recently played songs: $e");
      return [];
    }
  }

  Future<void> saveRecentlyPlayedSongs(List<RecentlyPlayed> songs) async {
    await _isar.writeTxn(() async {
      await _isar.recentlyPlayeds.clear(); // Clear old data
      await _isar.recentlyPlayeds.putAll(songs);
    });
  }

  // ===================== Liked Songs Methods ==========================

  Future<List<LikedSongs>> loadLikedSongs() async {
    try {
      return await _isar.likedSongs.where().sortByLikedAt().findAll();
    } catch (e) {
      print("Error loading liked songs: $e");
      return [];
    }
  }

  Future<void> saveLikedSongs(List<LikedSongs> songs) async {
    await _isar.writeTxn(() async {
      await _isar.likedSongs.clear(); // Clear old data
      await _isar.likedSongs.putAll(songs);
    });
  }

  // ===================== Playlist Methods ============================

  Future<List<Playlist>> loadPlaylists() async {
    try {
      return await _isar.playlists.where().findAll();
    } catch (e) {
      print("Error loading playlists: $e");
      return [];
    }
  }

  Future<void> savePlaylists(List<Playlist> playlists) async {
    await _isar.writeTxn(() async {
      await _isar.playlists.putAll(playlists);
    }).then((_) {
      print('Playlists saved to Isar.');
    }).catchError((e) {
      print("Error saving playlists: $e");
    });
  }

  void addSongToPlaylistInIsar(Playlist playlist, PlaylistSong playlistSong) {
    _isar.writeTxn(() async {
      try {
        // Save the song first so it gets an ID
        final songId = await _isar.playlistSongs.put(playlistSong);
        final savedSong = await _isar.playlistSongs.get(songId);

        if (savedSong != null) {
          playlist.songs.add(savedSong);
          await playlist.songs.save(); // Save the IsarLinks
          print('Song "${savedSong.songName}" added to playlist "${playlist.playlistName}"');
        }
      } catch (e) {
        print('Error adding song to playlist: $e');
      }
    });
  }

  Future<void> removePlaylistSong(int songId) async {
    await _isar.writeTxn(() async {
      await _isar.playlistSongs.delete(songId);
    }).then((_) {
      print("Song with ID $songId removed from Isar.");
    }).catchError((e) {
      print("Error removing song: $e");
    });
  }
}
