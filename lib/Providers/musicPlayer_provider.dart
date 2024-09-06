import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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

  late AssetsAudioPlayer _player = AssetsAudioPlayer();
  AssetsAudioPlayer get player => _player;

  void getNewPlayer() {
    _player = AssetsAudioPlayer();
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

  Future<Duration?> fetchSong(
      String theSongName, SearchProvider provider) async {
    final yt = YoutubeExplode();
    try {
      // Stop player if it's currently playing
      if (_player.isPlaying.value) {
        await _player.stop();
      }

      var songName = provider.selectedSongDetails;
      if (songName != null) {
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        audioUrl = manifest.audioOnly.first.url;

        // Dispose of previous player instance if necessary
        if (_player != null) {
          await _player.dispose();
        }

        // Reinitialize the player
        _player = AssetsAudioPlayer();

        try {
          await _player.open(
              Audio.network(audioUrl.toString(),
                  metas: Metas(
                      title: provider.selectedSongName,
                      artist: provider.selectedSongArtist,
                      album: provider.selectedSongAlbum,
                      image: MetasImage(
                          path: provider.selectedSongImage,
                          type: ImageType.network))),
              showNotification: true,
              respectSilentMode: true,
              autoStart: true,
              playInBackground: PlayInBackground.enabled,
              notificationSettings: NotificationSettings(
                seekBarEnabled: true,
                // stopEnabled: true,
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
              ));

          notifyListeners();
          return video.duration;
        } on AssetsAudioPlayerError catch (e) {
          print('Error during audio playback: $e');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching song: $e');
      }
    }
    return null;
  }
}
