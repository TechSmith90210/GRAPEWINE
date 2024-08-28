import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:marquee/marquee.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import '../../Colors/colors.dart';
import '../../Providers/search_provider.dart';

class SongPlayer2Screen extends StatefulWidget {
  const SongPlayer2Screen({super.key});

  @override
  State<SongPlayer2Screen> createState() => _SongPlayer2ScreenState();
}

class _SongPlayer2ScreenState extends State<SongPlayer2Screen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    // If the player is not initialized and no song is playing
    if (!musicPlayerProvider.firstSongRun &&
        !musicPlayerProvider.isInitialized &&
        !musicPlayerProvider.player.isPlaying.value == true) {
      musicPlayerProvider.setFirstSongRun();
      musicPlayerProvider.setInitialization();
      musicPlayerProvider.fetchSong(
          searchProvider.selectedSongName, searchProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    MiniplayerController miniplayerController =
        Provider.of<MiniplayerController>(context);
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
                  const SizedBox(
                    height: 30,
                  ),
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
                              Consumer<SearchProvider>(
                                builder: (context, provider, child) {
                                  return Container(
                                    width: 220,
                                    height: 30,
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
                        child: StreamBuilder<Playing?>(
                          // Correctly access the current playing stream
                          stream: provider.player.current,
                          builder: (context, snapshot) {
                            final playing = snapshot.data;
                            // Safely access the duration of the audio, defaulting to Duration.zero if not available
                            final duration = playing?.audio.duration ?? Duration.zero;

                            return StreamBuilder<Duration>(
                              // Correctly access the current position stream
                              stream: provider.player.currentPosition,
                              builder: (context, positionSnapshot) {
                                final position = positionSnapshot.data ?? Duration.zero;

                                return ProgressBar(
                                  progress: position,
                                  total: duration,
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
                                  onSeek: (newPosition) {
                                    provider.player.seek(newPosition);
                                    print('Player seeked to $newPosition');
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Consumer<MusicPlayerProvider>(
                    builder: (context, provider, child) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              try {
                                // Ensure the player is playing or paused before seeking
                                if (provider.player.isPlaying.value || provider.player.isPlaying.value == false) {
                                  var currentPosition = provider.player.currentPosition.value;

                                  // Safely handle the currentPosition and subtract 5 seconds
                                  var rewindedPosition = (currentPosition != null)
                                      ? currentPosition - const Duration(seconds: 5)
                                      : Duration.zero;

                                  // Ensure rewindedPosition does not go below zero
                                  if (rewindedPosition < Duration.zero) {
                                    rewindedPosition = Duration.zero;
                                  }

                                  // Seek to the new position
                                  await provider.player.seek(rewindedPosition);
                                }
                              } catch (e) {
                                // Handle any errors during the seek operation
                                print('Error seeking position: $e');
                              }
                            },

                            icon: Icon(
                              Icons.skip_previous_rounded,
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
                              if (provider.player.isPlaying.value == true) {
                                await provider.player.pause();
                              } else {
                                await provider.player.play();
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
                                  try {
                                    // Ensure the player is either playing or paused before seeking
                                    if (provider.player.isPlaying.value || provider.player.isPlaying.value ==false) {
                                      var currentPosition = provider.player.currentPosition.value;

                                      // Safely handle the currentPosition and add 5 seconds
                                      var fastForwardPosition = (currentPosition != null)
                                          ? currentPosition + const Duration(seconds: 5)
                                          : Duration.zero;

                                      // Get the total duration of the audio to avoid seeking beyond it
                                      var totalDuration = provider.player.current.value?.audio.duration ?? Duration.zero;

                                      // Ensure fastForwardPosition does not exceed the total duration
                                      if (fastForwardPosition > totalDuration) {
                                        fastForwardPosition = totalDuration;
                                      }

                                      // Seek to the new position
                                      await provider.player.seek(fastForwardPosition);
                                    }
                                  } catch (e) {
                                    // Handle any errors during the seek operation
                                    print('Error seeking position: $e');
                                  }
                                },

                                icon: Icon(
                                  Icons.skip_next_rounded,
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
