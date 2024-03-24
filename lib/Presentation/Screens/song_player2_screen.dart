import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:marquee/marquee.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../Colors/colors.dart';
import '../../Providers/search_provider.dart';
import 'the_music_pages.dart';

class SongPlayer2Screen extends StatefulWidget {
  const SongPlayer2Screen({super.key});

  @override
  State<SongPlayer2Screen> createState() => _SongPlayer2ScreenState();
}

class _SongPlayer2ScreenState extends State<SongPlayer2Screen> {
  Duration? duration;
  Uri? audioUrl;
  @override
  Future<void> fetchSong(String theSongName) async {
    var provider = Provider.of<SearchProvider>(context, listen: false);
    var musicProvider = Provider.of<MusicPlayerProvider>(context);
    var songName = provider.selectedSongDetails;

    if (songName != null) {
      final yt = YoutubeExplode();
      final video = (await yt.search.search(songName)).first;
      final videoId = video.id.value;
      duration = video.duration;
      // setState(() {});
      musicProvider.updateDuration(duration);
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      audioUrl = manifest.audioOnly.first.url;
      musicProvider.player.play(UrlSource(audioUrl.toString()));
    }
  }

  // Future<void> _initializeState() async {
  //   // super.initState();
  //   Future.delayed(Duration.zero, () async {
  //     var provider = Provider.of<SearchProvider>(context, listen: false);
  //     var musicPlayerProvider =
  //         Provider.of<MusicPlayerProvider>(context, listen: false);
  //     var songName = provider.selectedSongDetails;
  //     if (songName != null) {
  //       if (musicPlayerProvider.player.state == PlayerState.playing) {
  //         await musicPlayerProvider.player.stop();
  //         await musicPlayerProvider
  //             .fetchSong(songName, provider)
  //             .then((newDuration) {
  //           musicPlayerProvider.updateDuration(newDuration);
  //         });
  //       } else {
  //         await musicPlayerProvider
  //             .fetchSong(songName, provider)
  //             .then((newDuration) {
  //           musicPlayerProvider.updateDuration(newDuration);
  //         });
  //       }
  //     }
  //   });
  // }

  //
  // @override
  // void initState() {
  //   super.initState();
  //   // Future.delayed(Duration.zero, () {
  //   //   var provider = Provider.of<SearchProvider>(context, listen: false);
  //   //   var songName = provider.selectedSongDetails;
  //   //   if (songName != null) {
  //   //     fetchSong(songName);
  //   //   // get the song details
  //   //   }
  //   // });
  // }
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    if (!musicPlayerProvider.isInitialized &&
        musicPlayerProvider.player.state == PlayerState.stopped) {
      if (!musicPlayerProvider.isInitialized) {
        musicPlayerProvider.setInitialization();
        fetchSong(searchProvider.selectedSongName);
      }
    }
  }

  // @override
  // void dispose() {
  //   var musicPlayerProvider =
  //       Provider.of<MusicPlayerProvider>(context, listen: false);
  //   // musicPlayerProvider.player.dispose();
  //   if (musicPlayerProvider.isInitialized) {
  //     musicPlayerProvider.setInitialization();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    MiniplayerController miniplayerController =
        Provider.of<MiniplayerController>(context);
    // _initializeState();
    return Scaffold(
      backgroundColor: blackColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Now Playing',
                    style: GoogleFonts.redHatDisplay(
                        color: greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Consumer<SearchProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.selectedSongName ?? 'No Song Playing',
                        style: GoogleFonts.redHatDisplay(
                            color: yellowColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        miniplayerController.animateToHeight(height: 80);
                      },
                      icon: Icon(Icons.keyboard_arrow_down_sharp,
                          size: 50, color: darkgreyColor)),
                  Consumer<SearchProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(provider.selectedSongImage ??
                                  'https://play-lh.googleusercontent.com/tpok7cXkBGfq75J1xF9Lc5e7ydTix7bKN0Ehy87VP2555f8Lnmoj1KJNUlQ7-4lIYg4'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(11)),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<MusicPlayerProvider>(
                    builder: (context, provider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                provider.isLyrics
                                    ? Icons.textsms_rounded
                                    : Icons.textsms_outlined,
                                size: 30,
                              ),
                              onPressed: () {
                                provider.showLyrics();
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
                              Consumer<SearchProvider>(
                                builder: (context, provider, child) {
                                  return Container(
                                    width: 220,
                                    height: 35,
                                    child: provider.selectedSongName.length >=
                                            30
                                        ? Marquee(
                                            showFadingOnlyWhenScrolling: true,
                                            text: provider.selectedSongName!,
                                            style: GoogleFonts.redHatDisplay(
                                                color: whiteColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700),
                                            scrollAxis: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            blankSpace: 10.0,
                                            velocity: 50.0,
                                            // startPadding: 10.0,
                                            accelerationDuration:
                                                Duration(seconds: 2),
                                            accelerationCurve: Curves.linear,
                                            decelerationDuration:
                                                Duration(milliseconds: 0),
                                            decelerationCurve: Curves.easeOut,
                                            pauseAfterRound:
                                                Duration(seconds: 7),
                                            startAfter: Duration(seconds: 7),
                                          )
                                        : Text(
                                            provider.selectedSongName,
                                            style: GoogleFonts.redHatDisplay(
                                                color: whiteColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700),
                                          ),
                                  );
                                },
                              ),

                              Consumer<SearchProvider>(
                                builder: (context, provider, child) {
                                  return Container(
                                      width: 220,
                                      height: 30,
                                      child: provider
                                                  .selectedSongArtist.length >=
                                              30
                                          ? Marquee(
                                              showFadingOnlyWhenScrolling: true,
                                              text: provider.selectedSongArtist,
                                              style: GoogleFonts.redHatDisplay(
                                                  color: darkgreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              scrollAxis: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              blankSpace: 10.0,
                                              velocity: 50.0,
                                              // startPadding: 10.0,
                                              accelerationDuration:
                                                  Duration(seconds: 1),
                                              accelerationCurve: Curves.linear,
                                              // decelerationDuration: Duration(milliseconds: 500),
                                              decelerationCurve: Curves.easeOut,
                                              textDirection: TextDirection.ltr,
                                              pauseAfterRound:
                                                  Duration(seconds: 10),
                                              startAfter: Duration(seconds: 7),
                                            )
                                          : Text(
                                              provider.selectedSongArtist,
                                              style: GoogleFonts.redHatDisplay(
                                                  color: darkgreyColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ));
                                },
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
                          Consumer<MusicPlayerProvider>(
                            builder: (context, provider, child) {
                              return IconButton(
                                onPressed: () {
                                  provider.likeSong();
                                },
                                icon: Icon(
                                    provider.isLiked
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: provider.isLiked
                                        ? purpleColor
                                        : whiteColor,
                                    size: 30),
                                color: whiteColor,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<MusicPlayerProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        width: 330,
                        child: StreamBuilder(
                            stream: provider.player.onPositionChanged,
                            builder: (context, data) {
                              return ProgressBar(
                                progress:
                                    data.data ?? const Duration(seconds: 0),
                                total:
                                    provider.duration ?? Duration(seconds: 0),
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
                                  provider.player.seek(duration);
                                  print('player seeked to $duration');
                                },
                              );
                            }),
                      );
                    },
                  ),
                  Consumer<MusicPlayerProvider>(
                    builder: (context, provider, child) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              var currentPosition =
                                  await provider.player.getCurrentPosition();
                              var rewindedPostion =
                                  currentPosition! - Duration(seconds: 5);
                              await provider.player.seek(rewindedPostion);
                            },
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
                              provider.playSong();
                              if (provider.player.state ==
                                  PlayerState.playing) {
                                await provider.player.pause();
                              } else {
                                await provider.player.resume();
                              }
                              // setState(() {});
                            },
                            icon: Icon(
                              provider.isPlayed
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause_rounded,
                              size: 65,
                            ),
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Consumer<MusicPlayerProvider>(
                            builder: (context, provider, child) {
                              return IconButton(
                                onPressed: () async {
                                  var currentPosition = await provider.player
                                      .getCurrentPosition();
                                  var rewindedPostion =
                                      currentPosition! + Duration(seconds: 5);
                                  await provider.player.seek(rewindedPostion);
                                },
                                icon: Icon(
                                  Icons.fast_forward_rounded,
                                  size: 55,
                                ),
                                color: whiteColor,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
