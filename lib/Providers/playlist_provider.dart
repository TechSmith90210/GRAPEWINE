import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/playlist.dart';
import 'package:provider/provider.dart';

import '../Data/services/local_helper.dart';
import '../models/song_model.dart';
import 'musicPlayer_provider.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Playlist> _playlists = [];
  List<Playlist> get playlists => _playlists;

  // Load playlists from LocalHelper and store them in _playlists
  // Fetch playlists from Isar and convert IsarLinks<PlaylistSong> to List<PlaylistSong> without reassigning
  Future<void> loadPlaylists(LocalHelper localHelper) async {
    // Load playlists from Isar using the passed localHelper instance
    _playlists = await localHelper.loadPlaylists();

    // Convert IsarLinks<PlaylistSong> to List<PlaylistSong> for use
    for (var playlist in _playlists) {
      // Instead of reassigning, use the add() method to add songs to the IsarLinks
      playlist.songs.addAll(playlist.songs.toList()); // Convert IsarLinks to List and add the songs
    }

    // Notify listeners after loading playlists
    notifyListeners();
  }


// Assuming _playlists is a List<Playlist> declared in your provider
  Playlist getPlaylistById(int id) {
    // Return the playlist with the given id
    return _playlists.firstWhere((playlist) => playlist.id == id);
  }

  void createPlaylist(Playlist playlist) {
    int newId = _playlists.isNotEmpty
        ? _playlists.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;

    if (!_playlists.any((existingPlaylist) =>
        existingPlaylist.playlistName == playlist.playlistName)) {
      playlist = Playlist(
        id: newId,
        playlistName: playlist.playlistName,
        imageUrl: playlist.imageUrl,
      );
      _playlists.add(playlist);
      LocalHelper().savePlaylists(_playlists); // Save updated playlists
      notifyListeners();
    } else {
      print('Playlist with the same name exists! Choose a different name!');
    }
  }

  void deletePlaylist(int playlistId,BuildContext cx) {
    try {
      // Locate the playlist to be deleted
      final playlistIndex = _playlists.indexWhere((playlist) => playlist.id == playlistId);
      if (playlistIndex == -1) {
        throw Exception('Playlist with ID $playlistId does not exist!');
      }

      final playlist = _playlists[playlistIndex];

      // Clear IsarLinks for the playlist (detach the songs)
      LocalHelper().clearPlaylistSongs(playlist);

      // Remove the playlist from the local list
      _playlists.removeAt(playlistIndex);

      // Save updated playlists back to Isar
      LocalHelper().savePlaylists(_playlists);

      // Notify listeners to update the UI
      notifyListeners();

      print('Playlist "${playlist.playlistName}" deleted successfully.');
    } catch (e) {
      print('Error deleting playlist: $e');
    }
  }

  void addSongToPlaylist(int playlistId, PlaylistSong playlistSong) {
    // Find the playlist locally in _playlists
    final playlistIndex = _playlists.indexWhere((p) => p.id == playlistId);
    if (playlistIndex == -1) {
      throw Exception('Playlist with ID $playlistId does not exist!');
    }

    final playlist = _playlists[playlistIndex];

    // Add the song to the playlist in Isar using LocalHelper
    LocalHelper().addSongToPlaylistInIsar(playlist, playlistSong);

    // Update local state by reloading the playlist links
    playlist.songs.add(playlistSong); // Add locally for instant UI updates
    _playlists[playlistIndex] = playlist;

    // Notify listeners to reflect UI changes
    notifyListeners();

    print('Song "${playlistSong.songName}" added to playlist "${playlist.playlistName}".');
  }




  void removeSongFromPlaylist(int playlistId, int songId) async {
    // Find the playlist by ID
    final playlist = _playlists.firstWhere(
      (element) => element.id == playlistId,
      orElse: () =>
          throw Exception('Playlist with ID $playlistId does not exist!'),
    );

    // Load the songs from the IsarLinks
    await playlist.songs.load(); // Load the linked songs into a list

    // Find the song by songId
    final songToRemove = playlist.songs.firstWhere(
      (song) => song.id == songId,
      orElse: () => throw Exception(
          'Song with ID $songId does not exist in the playlist!'),
    );

    // Remove the song from the IsarLink using removeLink
    playlist.songs.remove(songToRemove);

    // Save the updated playlist (unlinking happens automatically)
    await LocalHelper().savePlaylists(_playlists);

    // Optionally, remove the song entirely from Isar if needed
    await LocalHelper().removePlaylistSong(songToRemove.id);

    // Update positions of remaining songs
    List<PlaylistSong> updatedSongs =
        playlist.songs.toList(); // Convert IsarLinks to List

    // Update positions of remaining songs
    for (int i = 0; i < updatedSongs.length; i++) {
      updatedSongs[i].positionInPlaylist = i;
    }

    // Notify listeners
    notifyListeners();
  }

  // Method to play the entire playlist
  Future<void> playPlaylist(BuildContext context, int playlistId) async {
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    var recentProvider =
        Provider.of<RecentlyPlayedProvider>(context, listen: false);
    var playlist = getPlaylistById(playlistId);

    List<Song> playlistSongs = playlist.songs.map((songModel) {
      return Song(
        songName: songModel.songName,
        artists: songModel.songArtists,
        imageUrl: songModel.songImageUrl,
      );
    }).toList();

    // Play the entire playlist using the MusicPlayerProvider
    await musicPlayerProvider.fetchPlaylist(
        playlistSongs, searchProvider, recentProvider);

    notifyListeners();
  }

  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void setEditing(bool editing) {
    _isEditing = editing;
    notifyListeners();
  }

  // Load playlists from Isar
  Future<void> loadPlaylistsFromIsar(LocalHelper localHelper) async {
    final playlists = await localHelper.loadPlaylists();

    _playlists = playlists;
    notifyListeners();

    print('Loaded playlists!');
  }
}
