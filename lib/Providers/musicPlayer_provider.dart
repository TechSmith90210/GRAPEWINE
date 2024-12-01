import 'package:assets_audio_player/assets_audio_player.dart'
    as just; // Use 'just' prefix
import 'package:flutter/foundation.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
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

  // Fetch a single song
  Future<Duration?> fetchSong(
      String theSongName, SearchProvider provider) async {
    final yt = YoutubeExplode();
    try {
      var songName = provider.selectedSongDetails;
      if (songName != null) {
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        audioUrl = manifest.audioOnly.first.url;

        if (_player != null) {
          await _player.dispose();
        }

        _player = just.AssetsAudioPlayer(); // Reinitialize with just prefix

        await _player.open(
          just.Audio.network(audioUrl.toString(), // Use just prefix for Audio
              metas: just.Metas(
                title: provider.selectedSongName,
                artist: provider.selectedSongArtist,
                album: provider.selectedSongAlbum,
                image: just.MetasImage(
                  path: provider.selectedSongImage,
                  type: just.ImageType.network, // Use just prefix for ImageType
                ),
              )),
          showNotification: true,
          respectSilentMode: true,
          autoStart: true,
          playInBackground: just.PlayInBackground.enabled, // Use just prefix
          notificationSettings: just.NotificationSettings(
            seekBarEnabled: true,
            playPauseEnabled: true,
            customPlayPauseAction: (player) async {
              if (player.isPlaying.value) {
                await player.pause();
                togglePlayPause(); // Ensure state is updated
              } else {
                await player.play();
                togglePlayPause(); // Ensure state is updated
              }
            },
          ),
        );

        notifyListeners();
        return video.duration;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching song: $e');
      }
    }
    return null;
  }

  Future<void> fetchPlaylist(
      List<Song> playlist, SearchProvider provider) async {
    final yt = YoutubeExplode();
    try {
      List<just.Audio> audioList = []; // Use just prefix for Audio list

      // Loop through each song in the playlist
      for (var song in playlist) {
        var songName = song.songName;
        if (songName != null) {
          final video = (await yt.search.search(songName)).first;
          final videoId = video.id.value;
          var manifest = await yt.videos.streamsClient.getManifest(videoId);
          audioUrl = manifest.audioOnly.first.url;

          // Create the Audio object for each song in the playlist
          just.Audio audio = just.Audio.network(
            audioUrl.toString(),
            metas: just.Metas(
              title: song.songName,
              artist: song.artists,
              album: 'album',
              image: just.MetasImage(
                path: song.imageUrl,
                type: just.ImageType.network, // Use just prefix for ImageType
              ),
            ),
          );
          audioList.add(audio);
        }
      }

      // Open the playlist using just prefix
      await _player.open(
        just.Playlist(audios: audioList), // Use just prefix for Playlist
        loopMode:
            just.LoopMode.playlist, // Loop the full playlist with just prefix
        showNotification: true,
        respectSilentMode: true,
        autoStart: true,
        playInBackground: just.PlayInBackground.enabled, // Use just prefix
        notificationSettings: just.NotificationSettings(
          seekBarEnabled: true,
          playPauseEnabled: true,
          customNextAction: (player) async {
            await _player.next(stopIfLast: true); // Use just prefix for next
            final currentSongMetas = _player.current.value!.audio.audio.metas;

            // Update the SearchProvider with the current song's title, artists, and image
            provider.setSongName(currentSongMetas.title!);
            provider.setSongArtist(currentSongMetas.artist!);
            provider.setSongImage(currentSongMetas.image!.path);
          },
          customPrevAction: (player) async {
            await _player.previous(); // Use just prefix for next
            final currentSongMetas = _player.current.value!.audio.audio.metas;

            // Update the SearchProvider with the current song's title, artists, and image
            provider.setSongName(currentSongMetas.title!);
            provider.setSongArtist(currentSongMetas.artist!);
            provider.setSongImage(currentSongMetas.image!.path);
          },
          customPlayPauseAction: (player) async {
            if (player.isPlaying.value) {
              await player.pause();
              togglePlayPause(); // Ensure state is updated
            } else {
              await player.play();
              togglePlayPause(); // Ensure state is updated
            }
          },
        ),
      );

      // Set the song details for the current song in the playlist
      // Get the current song's metadata
      final currentSongMetas = _player.playlist!.audios.first.metas;

      // Update the provider with the current song's title and artist
      provider.setSongName(currentSongMetas.title!);
      provider.setSongArtist(currentSongMetas.artist!);
      provider.setSongImage(currentSongMetas.image!.path);

      // Notify listeners to update the UI
      provider.notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching playlist: $e');
      }
    }
  }

  // Functions for controlling playlist

  void playAtIndex(int index) {
    if (_player.isPlaying.value) {
      _player.playlistPlayAtIndex(index);
    }
  }
}
