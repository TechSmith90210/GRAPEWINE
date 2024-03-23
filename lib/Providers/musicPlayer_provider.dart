import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/CustomStrings.dart';
import 'package:grapewine_music_app/Presentation/Screens/the_music_pages.dart';
import 'package:grapewine_music_app/Presentation/widgets/ArtistChipsWidget.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:marquee/marquee.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:marquee_text/marquee_text.dart';
import '../../Colors/colors.dart';

NavigatorProvider _navigatorProvider=NavigatorProvider();
class MusicPlayerProvider with ChangeNotifier {
  bool _isLyrics = false;
  bool get isLyrics => _isLyrics;

  void showLyrics() {
    _isLyrics = !_isLyrics;
    notifyListeners();
  }

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  void likeSong() {
    _isLiked = !_isLiked;
    notifyListeners();
  }

  bool _isPlayed = false;
  bool get isPlayed => _isPlayed;

  void playSong() {
    _isPlayed = !_isPlayed;
    notifyListeners();
  }

  List<String> _artistImages = [
    // Cudi
    'https://i.scdn.co/image/ab6761610000e5eb876faa285687786c3d314ae0',
    //pharell
    'https://i.scdn.co/image/ab6761610000e5ebf0789cd783c20985ec3deb4e',
    //travis
    'https://i.scdn.co/image/ab6761610000e5eb19c2790744c792d05570bb71',
  ];
  List<String> get artistImages => _artistImages;

  List<String> _artistNames = ['Kid Cudi', 'Pharrell Williams', 'Travis Scott'];
  List<String> get artistNames => _artistNames;

  double _value = 2.0;
  double get value => _value;

  void setVolume(double newVolume) {
    _value = newVolume;
    notifyListeners();
  }

  final player = AudioPlayer();
  Duration? duration;
  Uri? audioUrl;
  Future<Duration?> fetchSong(String theSongName, BuildContext context) async {
    var provider = Provider.of<SearchProvider>(context, listen: false);
    var songName = provider.selectedSongDetails;
    if (songName != null) {
      final yt = YoutubeExplode();
      final video = (await yt.search.search(songName)).first;
      final videoId = video.id.value;
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      audioUrl = manifest.audioOnly.first.url;
      player.play(UrlSource(audioUrl.toString()));
      return video.duration;
    }
    return null;
  }

}
