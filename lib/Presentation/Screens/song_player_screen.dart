import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/CustomStrings.dart';
import 'package:grapewine_music_app/Presentation/widgets/ArtistChipsWidget.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../Colors/colors.dart';

class SongPlayerScreen extends StatefulWidget {
  const SongPlayerScreen({super.key});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  final player = AudioPlayer();
  Duration? duration;
  Uri? audioUrl;

  @override
  void initState() {
    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotify = SpotifyApi(credentials);
    final musicTrackId = '11BbPUv7NlzlcbY7AmHHKy?si=71a57e5a016d4234';
    spotify.tracks.get(musicTrackId).then((track) async {
      String? songName = track.name;
      if (songName != null) {
        final yt = YoutubeExplode();
        final video = (await yt.search.search(songName)).first;
        final videoId = video.id.value;
        duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        audioUrl = manifest.audioOnly.first.url;
        // player.play(UrlSource(audioUrl.toString()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var musicPlayerProvider = Provider.of<MusicPlayerProvider>(context);
    return Scaffold(
      backgroundColor: darkblueBubbleColor,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Now Playing',
                  style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'At The Party',
                  style: GoogleFonts.redHatDisplay(
                      color: yellowColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Icon(Icons.keyboard_arrow_down_sharp,
                    size: 55, color: darkgreyColor),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://i.scdn.co/image/ab67616d0000b273581f1908ffdfef41ca3ce7f4'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(11)),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          musicPlayerProvider.isLyrics
                              ? Icons.textsms_rounded
                              : Icons.textsms_outlined,
                          size: 30,
                        ),
                        onPressed: () {
                          musicPlayerProvider.showLyrics();
                        },
                        color: whiteColor),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'At The Party',
                          style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Kid Cudi, Pharell Williams, Travis Scott',
                          style: GoogleFonts.redHatDisplay(
                              color: darkgreyColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    IconButton(
                      onPressed: () {
                        musicPlayerProvider.likeSong();
                      },
                      icon: Icon(
                          musicPlayerProvider.isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: musicPlayerProvider.isLiked
                              ? purpleColor
                              : whiteColor,
                          size: 30),
                      color: whiteColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 330,
                  child: StreamBuilder(
                      stream: player.onPositionChanged,
                      builder: (context, data) {
                        return ProgressBar(
                          progress: data.data ?? const Duration(seconds: 0),
                          total: duration ?? Duration(seconds: 0),
                          progressBarColor: whiteColor,
                          thumbColor: whiteColor,
                          baseBarColor: backgroundColor,
                          bufferedBarColor: greyColor,
                          thumbGlowColor: purpleColor,
                          thumbGlowRadius: 0,
                          timeLabelPadding: 5,
                          timeLabelTextStyle: GoogleFonts.redHatDisplay(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                          ),
                          onSeek: (duration) {
                            player.seek(duration);
                            print('player seeked to $duration');
                          },
                        );
                      }),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.fast_rewind_rounded,
                        size: 55,
                      ),
                      color: whiteColor,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    IconButton(
                      onPressed: () async {
                        musicPlayerProvider.playSong();
                        if (player.state == PlayerState.playing) {
                          await player.pause();
                        } else {
                          await player.resume();
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        musicPlayerProvider.isPlayed
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        size: 65,
                      ),
                      color: whiteColor,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    IconButton(
                      onPressed: () {
                        player.state = PlayerState.completed;
                      },
                      icon: Icon(
                        Icons.fast_forward_rounded,
                        size: 55,
                      ),
                      color: whiteColor,
                    ),
                  ],
                ),
                Container(
                  width: 360,
                  child: InteractiveSlider(
                    startIcon: const Icon(Icons.volume_down),
                    endIcon: const Icon(Icons.volume_up),
                    brightness: Brightness.light,
                    initialProgress: 0.0,
                    iconSize: 30,
                    unfocusedHeight: 10,
                    focusedHeight: 30,
                    min: 1.0,
                    max: 15.0,
                    onChanged: (value) {
                      musicPlayerProvider.setVolume(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ArtistChipsWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
