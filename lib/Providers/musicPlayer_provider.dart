import 'package:assets_audio_player/assets_audio_player.dart'
    as just; // Use 'just' prefix
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/recently_played.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/song_model.dart';

class MusicPlayerProvider with ChangeNotifier {
  bool _firstSongRun = false;
  bool get firstSongRun => _firstSongRun;

  void setFirstSongRun() {
    _firstSongRun = true;
    notifyListeners();
  }

  bool _isLyrics = false;
  bool get isLyrics => _isLyrics;

  void showLyrics() {
    _isLyrics = !_isLyrics;
    notifyListeners();
  }

  bool _isPlayed = false;
  bool get isPlayed => _isPlayed;

  void togglePlayPause() {
    if (_isPlayed) {
      _isPlayed = false;
      _player.pause(); // Pause the player
    } else {
      _isPlayed = true;
      _player.play(); // Start playing the player
    }
    notifyListeners();
  }

  final List<String> _artistImages = [
    'https://i.scdn.co/image/ab6761610000e5eb876faa285687786c3d314ae0', // Cudi
    'https://i.scdn.co/image/ab6761610000e5ebf0789cd783c20985ec3deb4e', // Pharrell
    'https://i.scdn.co/image/ab6761610000e5eb19c2790744c792d05570bb71', // Travis
  ];
  List<String> get artistImages => _artistImages;

  List<String> _artistNames = ['Kid Cudi', 'Pharrell Williams', 'Travis Scott'];
  List<String> get artistNames => _artistNames;

  double _value = 2.0;
  double get value => _value;

  void setVolume(double newVolume) {
    _value = newVolume;
    _player.setVolume(newVolume); // Adjust the volume of the player
    notifyListeners();
  }

  late just.AssetsAudioPlayer _player =
      just.AssetsAudioPlayer(); // Use just prefix
  just.AssetsAudioPlayer get player => _player;

  void getNewPlayer() {
    _player = just.AssetsAudioPlayer(); // Reinitialize with just prefix
    notifyListeners();
  }

  Duration? _duration = Duration.zero;
  Duration? get duration => _duration;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  void setInitialization() {
    _isInitialized = !_isInitialized;
    notifyListeners();
  }

  void updateDuration(Duration? newDuration) {
    _duration = newDuration;
    notifyListeners();
  }

  Uri? audioUrl;

  // Flag to prevent multiple simultaneous fetches
  bool _isFetching = false;

  Future<Duration?> fetchSong(
      String theSongName, SearchProvider provider) async {
    if (_isFetching) {
      print("Already fetching a song. Please wait.");
      return null; // Prevent duplicate calls
    }

    _isFetching = true; // Set the flag to block further fetches

    final yt = YoutubeExplode();
    try {
      // Check if the song details exist in the provider
      var songName = provider.selectedSongDetails;
      if (songName != null) {
        // Search for the video
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;

        // Get the audio stream manifest
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        final newAudioUrl = manifest.audioOnly.first.url;

        // Check if the song is already playing
        if (audioUrl == newAudioUrl &&
            _player != null &&
            _player.isPlaying.value) {
          print("The selected song is already playing.");
          return null; // Skip reinitialization if the song is already playing
        }

        // Update the current audio URL
        audioUrl = newAudioUrl;

        // Dispose of the previous player if it exists
        if (_player != null) {
          await _player.dispose();
        }

        // Reinitialize the player
        _player = just.AssetsAudioPlayer();

        // Clear the queue and add the new song to it
        _queue.clear(); // Clear the queue
        _queue.add(Song(
            songName: provider.selectedSongName,
            artists: provider.selectedSongArtist,
            imageUrl: provider.selectedSongImage,
            songId:
                provider.selectedSongId)); // Add the fetched song to the queue

        // Open the new audio and start playback
        await _player.open(
          just.Audio.network(audioUrl.toString(),
              metas: just.Metas(
                title: provider.selectedSongName,
                artist: provider.selectedSongArtist,
                album: provider.selectedSongAlbum,
                image: just.MetasImage(
                  path: provider.selectedSongImage,
                  type: just.ImageType.network,
                ),
              )),
          showNotification: true,
          respectSilentMode: true,
          autoStart: true,
          playInBackground: just.PlayInBackground.enabled,
          notificationSettings: just.NotificationSettings(
            seekBarEnabled: true,
            playPauseEnabled: true,
            customPlayPauseAction: (player) async {
              if (player.isPlaying.value) {
                await player.pause();
                togglePlayPause(); // Update play/pause state
              } else {
                await player.play();
                togglePlayPause(); // Update play/pause state
              }
            },
          ),
        );

        // Notify listeners to update the UI
        notifyListeners();

        // Return the duration of the video
        return video.duration;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching song: $e');
      }
    } finally {
      _isFetching = false; // Reset the flag when the method completes
    }
    return null;
  }

  Future<void> fetchPlaylist(
    List<Song> playlist,
    SearchProvider provider,
    RecentlyPlayedProvider recentProvider, {
    int? index,
  }) async {
    final yt = YoutubeExplode();

    try {
      // Clear the current queue
      _queue.clear();
      _player.stop();

      // Temporary lists to hold audios and songs
      List<just.Audio> audioList = [];
      List<Song> songQueue = [];

      for (var song in playlist) {
        var songName = song.songName;
        if (songName != null) {
          final video = (await yt.search.search(songName)).first;
          final videoId = video.id.value;
          var manifest = await yt.videos.streamsClient.getManifest(videoId);
          audioUrl = manifest.audioOnly.first.url;

          // Create an Audio object for just_audio
          just.Audio audio = just.Audio.network(
            audioUrl.toString(),
            metas: just.Metas(
              title: song.songName,
              artist: song.artists,
              album: provider.selectedSongAlbum,
              image: just.MetasImage(
                path: song.imageUrl,
                type: just.ImageType.network,
              ),
            ),
          );

          // Add the Audio object to the audio list
          audioList.add(audio);

          // Create a new Song object from the current song
          Song songItem = Song(
              songName: song.songName,
              artists: song.artists,
              imageUrl: song.imageUrl,
              songId: song.songId);

          // Add the Song object to the songQueue
          songQueue.add(songItem);
        }
      }

      // Update the queue with the new songQueue
      _queue.addAll(songQueue);

      // Open the playlist
      await _player.open(
        just.Playlist(audios: audioList, startIndex: index ?? 0),
        loopMode: just.LoopMode.playlist,
        showNotification: true,
        respectSilentMode: true,
        autoStart: true,
        playInBackground: just.PlayInBackground.enabled,
        notificationSettings: just.NotificationSettings(
          seekBarEnabled: true,
          playPauseEnabled: true,
          customNextAction: (player) =>
              handleNextAction(_player, provider, recentProvider),
          customPrevAction: (player) => handlePrevAction(_player, provider),
          customPlayPauseAction: (player) async {
            if (player.isPlaying.value) {
              await player.pause();
              togglePlayPause();
            } else {
              await player.play();
              togglePlayPause();
            }
          },
        ),
      );

      // Update metadata for the current song
      final currentSongMetas = _player.playlist!.audios.first.metas;
      provider.setSongName(currentSongMetas.title ?? 'Unknown Title');
      provider.setSongArtist(currentSongMetas.artist ?? 'Unknown Artist');
      provider.setSongImage(currentSongMetas.image?.path ?? '');

      // Listen for changes in the current playing song
      _player.current.listen((playing) {
        if (playing != null) {
          final currentMetas = playing.audio.audio.metas;
          provider.setSongName(currentMetas.title ?? 'Unknown Title');
          provider.setSongArtist(currentMetas.artist ?? 'Unknown Artist');
          provider.setSongImage(currentMetas.image?.path ?? '');
          provider.notifyListeners();
        }
      });

      // Notify provider listeners
      provider.notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }

  // Functions for controlling playlist
  Future<void> handleNextAction(just.AssetsAudioPlayer player,
      SearchProvider provider, RecentlyPlayedProvider recentProvider) async {
    try {
      await player.next(stopIfLast: true); // Play the next song, stop if last
      final currentSongMetas = player.current.value!.audio.audio.metas;

      // Update the SearchProvider with the current song's title, artists, and image
      provider.setSongName(currentSongMetas.title!);
      provider.setSongArtist(currentSongMetas.artist!);
      provider.setSongImage(currentSongMetas.image!.path);

      RecentlyPlayed recentlyPlayed = RecentlyPlayed()
        ..songName = currentSongMetas.title.toString()
        ..songArtists = currentSongMetas.artist.toString()
        ..songImageUrl = currentSongMetas.image!.path.toString()
        ..playedAt = DateTime.now();

      recentProvider.addRecentlyPlayed(recentlyPlayed);
    } catch (e) {
      if (kDebugMode) {
        print('Error handling next action: $e');
      }
    }
  }

  Future<void> handlePrevAction(
      just.AssetsAudioPlayer player, SearchProvider provider) async {
    try {
      await player.previous(); // Play the previous song
      final currentSongMetas = player.current.value!.audio.audio.metas;

      // Update the SearchProvider with the current song's title, artists, and image
      provider.setSongName(currentSongMetas.title!);
      provider.setSongArtist(currentSongMetas.artist!);
      provider.setSongImage(currentSongMetas.image!.path);
    } catch (e) {
      if (kDebugMode) {
        print('Error handling previous action: $e');
      }
    }
  }

  List<Song> _queue = [];

  List<Song> get queue => _queue;

  // Add a song to the queue
  void addSongToQueue(Song song) {
    _queue.add(song);
    notifyListeners(); // Notify listeners of changes
  }

  // Remove a song from the queue
  void removeSongFromQueue(int index) {
    _queue.removeAt(index);
    notifyListeners(); // Notify listeners of changes
  }

  void handleSongTap({
    required BuildContext context,
    required Song song,
  }) async {
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    var recentProvider =
        Provider.of<RecentlyPlayedProvider>(context, listen: false);
    musicPlayerProvider.setFirstSongRun();
    RecentlyPlayed recentlyPlayed = RecentlyPlayed()
      ..songName = song.songName
      ..songArtists = song.artists
      ..songImageUrl = song.imageUrl
      ..playedAt = DateTime.now()
      ..songId = song.songId!;

    searchProvider.setSongName(song.songName);
    searchProvider.setSongArtist(song.artists);
    searchProvider.setSongDetails(
        '${searchProvider.selectedSongName} ${searchProvider.selectedSongArtist} song audio');
    searchProvider.setSongId(song.songId!);
    print(searchProvider.selectedSongDetails);

    // Set the song cover image with default if necessary
    String songCover = song.imageUrl.isNotEmpty
        ? song.imageUrl
        : 'https://assets.audiomack.com/default-song-image.png';
    searchProvider.setSongImage(songCover);

    if (musicPlayerProvider.player.isPlaying.value) {
      await musicPlayerProvider.player.stop();

      await musicPlayerProvider
          .fetchSong(searchProvider.selectedSongName, searchProvider)
          .then((value) => musicPlayerProvider.updateDuration(value));
      recentProvider.toggleRecentlyPlayed(recentlyPlayed);
    } else {
      await musicPlayerProvider
          .fetchSong(searchProvider.selectedSongName, searchProvider)
          .then((value) => musicPlayerProvider.updateDuration(value));
      await musicPlayerProvider.player.play();
      recentProvider.toggleRecentlyPlayed(recentlyPlayed);
    }
  }

  void handlePlaylistTap({
    required BuildContext context,
    required List<Song> playlist,
    int? index,
  }) async {
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
    Provider.of<MusicPlayerProvider>(context, listen: false);
    var recentProvider =
    Provider.of<RecentlyPlayedProvider>(context, listen: false);

    // Get the current song from the playlist using the index
    Song song = playlist[index ?? 0]; // Fallback to the first song if index is null

    // Update MusicPlayerProvider and SearchProvider
    musicPlayerProvider.setFirstSongRun();
    searchProvider.setSongName(song.songName);
    searchProvider.setSongArtist(song.artists);
    searchProvider.setSongDetails(
        '${song.songName} ${song.artists} song audio');
    searchProvider.setSongId(song.songId!);

    print('Selected Song Details: ${searchProvider.selectedSongDetails}');

    // Create a RecentlyPlayed object and add it to the provider
    RecentlyPlayed recentlyPlayed = RecentlyPlayed()
      ..songName = song.songName
      ..songArtists = song.artists
      ..songImageUrl = song.imageUrl
      ..playedAt = DateTime.now()
      ..songId = song.songId!;

    recentProvider.addRecentlyPlayed(recentlyPlayed);

    // Fetch the playlist in MusicPlayerProvider
    await musicPlayerProvider.fetchPlaylist(
      playlist,
      searchProvider,
      recentProvider,
      index: index,
    );
  }

}
