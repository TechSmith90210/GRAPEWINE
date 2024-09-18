import 'package:flutter/material.dart';
import 'package:grapewine_music_app/models/liked_songs.dart';
import 'package:grapewine_music_app/models/recently_played.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalHelper extends ChangeNotifier {
  LocalHelper._internal();

  // using Singleton instance for efficiency
  static final LocalHelper _instance = LocalHelper._internal();

  factory LocalHelper() => _instance;

  late final Isar _isar;

  // Initialize Isar database
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [LikedSongsSchema, RecentlyPlayedSchema],
      directory: dir.path,
    );
  }

  // Load recently played songs from Isar
  Future<List<RecentlyPlayed>> loadRecentlyPlayedSongs() async {
    try {
      return await _isar.recentlyPlayeds.where().sortByPlayedAt().findAll();
    } catch (e) {
      print("Error loading recently played songs: $e");
      return [];
    }
  }

  // Method to save a list of recently played songs to Isar
  Future<void> saveRecentlyPlayedSongs(List<RecentlyPlayed> songs) async {
    final isarRecentlyPlayed = _isar.recentlyPlayeds;

    await _isar.writeTxn(() async {
      // Clear the existing recently played songs
      await isarRecentlyPlayed.clear();
      // Add the new recently played songs
      await isarRecentlyPlayed.putAll(songs);
    });
  }

  // Load liked songs from Isar
  Future<List<LikedSongs>> loadLikedSongs() async {
    try {
      return await _isar.likedSongs.where().sortByLikedAt().findAll();
    } catch (e) {
      print("Error loading Liked songs: $e");
      return [];
    }
  }

  // Method to save a list of recently played songs to Isar
  Future<void> saveLikedSongs(List<LikedSongs> songs) async {
    final isarLikedSongs = _isar.likedSongs;

    await _isar.writeTxn(() async {
      // Clear the existing recently played songs
      await isarLikedSongs.clear();
      print('cleared');
      // Add the new recently played songs
      await isarLikedSongs.putAll(songs);
      print('saved to isar');
    });
  }
}
