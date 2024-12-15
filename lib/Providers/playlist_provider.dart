import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';
import 'package:provider/provider.dart';

import '../models/song_model.dart';
import 'musicPlayer_provider.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<PlaylistModel> _playlists = [];
  List<PlaylistModel> get playlists => _playlists;

  PlaylistModel getPlaylistById(int id) {
    return playlists.firstWhere((playlist) => playlist.id == id);
  }

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
      print('Playlist with the same name exists! Choose a different name!');
    }
  }

  void deletePlaylist(int playlistId) {
    try {
      final playlist = _playlists.firstWhere(
        (playlist) => playlist.id == playlistId,
      );
      _playlists.remove(playlist);
      notifyListeners();
    } catch (e) {
      print('Playlist with ID $playlistId does not exist!');
    }
  }

  void addSongToPlaylist(int playlistId, PlaylistSongModel playlistSongModel) {
    final playlist = _playlists.firstWhere(
      (element) => element.id == playlistId,
      orElse: () =>
          throw Exception('Playlist with ID $playlistId does not exist!'),
    );

    playlistSongModel = PlaylistSongModel(
      playlistId: playlistId,
      positionInPlaylist: playlist.songs.length,
      songName: playlistSongModel.songName,
      songArtists: playlistSongModel.songArtists,
      songImageUrl: playlistSongModel.songImageUrl,
    );

    playlist.songs.add(playlistSongModel);
    notifyListeners();
  }

  void removeSongFromPlaylist(int playlistId, int songPosition) {
    final playlist = _playlists.firstWhere(
      (element) => element.id == playlistId,
      orElse: () =>
          throw Exception('Playlist with ID $playlistId does not exist!'),
    );

    if (songPosition >= 0 && songPosition < playlist.songs.length) {
      playlist.songs.removeAt(songPosition);

      for (int i = songPosition; i < playlist.songs.length; i++) {
        playlist.songs[i].positionInPlaylist = i;
      }

      notifyListeners();
    } else {
      print('Invalid position!');
    }
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

    // Optional: Notify listeners if needed
    notifyListeners();
  }

  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void setEditing(bool editing) {
    _isEditing = editing;
    notifyListeners();
  }
}
