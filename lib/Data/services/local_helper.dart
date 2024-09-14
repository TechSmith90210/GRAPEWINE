import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/recently_played.dart';
import '../../models/song.dart';

class LocalHelper extends ChangeNotifier {
  static LocalHelper? _instance;
  Isar? _isar;

  LocalHelper._internal();

  // Singleton pattern for LocalHelper
  static Future<LocalHelper> getInstance() async {
    if (_instance == null) {
      _instance = LocalHelper._internal();
      await _instance!._initialize();
    }
    return _instance!;
  }

  Future<void> _initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([SongModelSchema, RecentlyPlayedSchema],
        directory: dir.path);
    notifyListeners(); // Notify listeners that the database is ready
  }

  Isar? get isar => _isar;

  Future<void> addSongToRecentlyPlayed(SongModel song) async {
    final isar = this.isar;
    if (isar != null) {
      try {
        await isar.writeTxn(() async {
          // Add the song to the SongModel collection
          final songId = await isar.songModels
              .put(song); // This will give you the ID of the saved song

          // Add to RecentlyPlayed collection
          final recentlyPlayed = RecentlyPlayed()
            ..songId = songId // Use the ID from the SongModel
            ..playedAt = DateTime.now(); // Current timestamp
          await isar.recentlyPlayeds.put(recentlyPlayed);
        });
        notifyListeners(); // Notify listeners after adding the entry
      } catch (e) {
        // Handle exceptions
        print('Failed to add song to Recently Played: $e');
      }
    }
  }

  Future<List<SongModel>> getRecentlyPlayedSongs() async {
    final isar = this.isar;
    if (isar == null)
      return []; // Return an empty list if Isar is not initialized

    try {
      // Fetch RecentlyPlayed records sorted by playedAt in descending order
      final recentlyPlayedRecords =
          await isar.recentlyPlayeds.where().sortByPlayedAtDesc().findAll();

      // Extract the song IDs from the RecentlyPlayed records
      final songIds =
          recentlyPlayedRecords.map((record) => record.songId).toList();

      // Fetch the SongModel records with the IDs we have
      final songs = await Future.wait(
          songIds.map((id) => isar.songModels.get(id)).toList());

      // Filter out any null values (in case some IDs don't have corresponding songs)
      return songs.whereType<SongModel>().toList();
    } catch (e) {
      // Handle exceptions
      print('Failed to fetch recently played songs: $e');
      return [];
    }
  }
}
