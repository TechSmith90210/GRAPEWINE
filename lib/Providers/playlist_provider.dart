import 'package:flutter/material.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<PlaylistModel> _playlists = [];
  List<PlaylistModel> get playlists => _playlists;
  void createPlaylist(PlaylistModel playlistModel) {
    int newId = _playlists.isNotEmpty
        ? _playlists.map((e) => e.id!).reduce(
                  (a, b) => a > b ? a : b,
                ) +
            1
        : 1;
    if (!_playlists.any(
          (playlist) => playlist.playlistName == playlistModel.playlistName,
        ) &&
        !_playlists.any((playlist) => playlist.id == playlistModel.id)) {
      playlistModel = PlaylistModel(
          id: newId,
          playlistName: playlistModel.playlistName,
          imageUrl: playlistModel.imageUrl);
      _playlists.add(playlistModel);
      notifyListeners();
    } else {
      print('playlist with same name exists! choose a different name!');
    }
  }

  void deletePlaylist(int playlistId) {
    try {
      // Find the playlist by ID
      final playlist = _playlists.firstWhere(
        (playlist) => playlist.id == playlistId,
      );

      // If found, remove it
      _playlists.remove(playlist);
      notifyListeners();
    } catch (e) {
      print('Playlist with ID $playlistId does not exist!');
    }
  }

  void addSongToPlaylist(int playlistId, PlaylistSongModel playlistSongModel) {
    final playlist = _playlists.firstWhere(
          (element) => element.id == playlistId,
      orElse: () => throw Exception('Playlist with ID $playlistId does not exist!'),
    );

    if (!playlist.songs.any((element) => element.songName == playlistSongModel.songName)) {
      playlistSongModel = PlaylistSongModel(
        playlistId: playlistId,
        positionInPlaylist: playlist.songs.length,
        songName: playlistSongModel.songName,
        songArtists: playlistSongModel.songArtists,
        songImageUrl: playlistSongModel.songImageUrl,
      );

      playlist.songs.add(playlistSongModel);
      notifyListeners();
    } else {
      print('Song already exists in the playlist!');
    }
  }


  void removeSongFromPlaylist(int playlistId, int songPosition) {
    final playlist = _playlists.firstWhere(
      (element) => element.id == playlistId,
      orElse: () =>
          throw Exception('Playlist with ID $playlistId does not exist!'),
    );

    if (songPosition >= 0 && songPosition < playlist.songs.length) {
      // Remove the song at the specified position
      playlist.songs.removeAt(songPosition);

      // Update positions for remaining songs
      for (int i = songPosition; i < playlist.songs.length; i++) {
        playlist.songs[i].positionInPlaylist = i; // Reassign positions
      }

      notifyListeners(); // Notify listeners about the change
    } else {
      print('Invalid position!');
    }
  }
}
