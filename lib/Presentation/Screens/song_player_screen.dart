import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/CustomStrings.dart';
import 'package:grapewine_music_app/Presentation/Screens/the_music_pages.dart';
import 'package:grapewine_music_app/Presentation/widgets/ArtistChipsWidget.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:marquee/marquee.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:marquee_text/marquee_text.dart';
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
  Future<void> fetchSong(String theSongName) async {
    var provider = Provider.of<SearchProvider>(context, listen: false);
    var songName = provider.selectedSongDetails;
    if (songName != null) {
      final yt = YoutubeExplode();
      final video = (await yt.search.search(songName)).first;
      final videoId = video.id.value;
      duration = video.duration;
      setState(() {});
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      audioUrl = manifest.audioOnly.first.url;
      player.play(UrlSource(audioUrl.toString()));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var provider = Provider.of<SearchProvider>(context, listen: false);
      var songName = provider.selectedSongDetails;

      fetchSong(songName); // get the song details
    });
    // final credentials = SpotifyApiCredentials(
    //     CustomStrings.clientId, CustomStrings.clientSecret);
    // final spotify = SpotifyApi(credentials);
    // final musicTrackId = '11BbPUv7NlzlcbY7AmHHKy?si=71a57e5a016d4234';
    // spotify.tracks.get(musicTrackId).then((track) async {
    //   String? songName = track.name;
  }

  @override
  void dispose() {
    player.pause();
    player.dispose();
    // var provider1 = Provider.of<MusicPlayerProvider>(context);
    // provider1.isPlayed=false;
    // if (provider.isPlayed == true) {
    //   provider.playSong();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var musicPlayerProvider = Provider.of<MusicPlayerProvider>(context);
    var provider = Provider.of<SearchProvider>(context);
    String songname = provider.selectedSongName;
    String songArtist = provider.selectedSongArtist;
    String songCover = provider.selectedSongImage;
    return Scaffold(
      backgroundColor: eerieblackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    songname ?? 'No Song Playing',
                    style: GoogleFonts.redHatDisplay(
                        color: yellowColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TheMusicPages(),
                            ));
                      },
                      icon: Icon(Icons.keyboard_arrow_down_sharp,
                          size: 55, color: darkgreyColor)),
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(songCover ??
                              'https://play-lh.googleusercontent.com/tpok7cXkBGfq75J1xF9Lc5e7ydTix7bKN0Ehy87VP2555f8Lnmoj1KJNUlQ7-4lIYg4'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(11)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          // Text(
                          //   songname,
                          //   style: GoogleFonts.redHatDisplay(
                          //       color: whiteColor,
                          //       fontSize: 28,
                          //       fontWeight: FontWeight.w800),
                          // ),
                          Container(
                            width: 220,
                            height: 50,
                            child: songname != null && songname.isNotEmpty
                                ? Marquee(
                              text: songname!,
                              style: GoogleFonts.redHatDisplay(
                                  color: whiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 10.0,
                              velocity: 50.0,
                              // startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 2),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 0),
                              decelerationCurve: Curves.easeOut,
                              pauseAfterRound: Duration(seconds: 7),
                              startAfter: Duration(seconds: 7),
                            )
                                : Text(
                              "No Song Selected",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),


                          Container(
                            width: 220,
                            height: 50,
                            child: Marquee(
                              text: songArtist,
                              style: GoogleFonts.redHatDisplay(
                                  color: darkgreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 10.0,
                              velocity: 50.0,
                              // startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              // decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                              textDirection: TextDirection.ltr,
                              pauseAfterRound: Duration(seconds: 10),
                              startAfter: Duration(seconds: 7),
                            ),
                          ),
                          // Text(
                          //   songArtist,
                          //   style: GoogleFonts.redHatDisplay(
                          //       color: darkgreyColor,
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.w500),
                          // ),
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
                              ? Icons.play_arrow_rounded
                              : Icons.pause_rounded,
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
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // ArtistChipsWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
