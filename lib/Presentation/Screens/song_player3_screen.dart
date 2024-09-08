import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../../Providers/musicPlayer_provider.dart';
import '../widgets/MiniPlayerWidget.dart'; // Add this package to your pubspec.yaml for Marquee

class SongPlayer3Screen extends StatefulWidget {
  @override
  _SongPlayer3ScreenState createState() => _SongPlayer3ScreenState();
}

class _SongPlayer3ScreenState extends State<SongPlayer3Screen> {
  bool _isLyrics = false;
  bool _isLiked = false;
  String _songName = "Sample Song";
  String _songArtist = "Sample Artist";
  String _songImage =
      "https://play-lh.googleusercontent.com/tpok7cXkBGfq75J1xF9Lc5e7ydTix7bKN0Ehy87VP2555f8Lnmoj1KJNUlQ7-4lIYg4";
  Color _whiteColor = Colors.white;
  Color _darkGreyColor = Colors.grey;
  Color _purpleColor = Colors.purple;
  bool _isPlaying = false;

  Duration _currentPosition = Duration.zero;
  Duration _duration = Duration(minutes: 3, seconds: 30);

  void _toggleLyrics() {
    setState(() {
      _isLyrics = !_isLyrics;
    });
  }

  void _playPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seek(Duration newPosition) {
    setState(() {
      _currentPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Now Playing:',
                    style: GoogleFonts.redHatDisplay(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    truncateText(_songName ?? 'No Song Playing', 50),
                    style: GoogleFonts.redHatDisplay(
                        color: yellowColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_songImage ??
                          'https://play-lh.googleusercontent.com/tpok7cXkBGfq75J1xF9Lc5e7ydTix7bKN0Ehy87VP2555f8Lnmoj1KJNUlQ7-4lIYg4'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(11)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ListTile(
                      title: _songName.length >= 30
                          ? Marquee(
                              showFadingOnlyWhenScrolling: true,
                              text: _songName,
                              style: GoogleFonts.redHatDisplay(
                                  color: _whiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 10.0,
                              velocity: 50.0,
                              accelerationDuration: Duration(seconds: 2),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 0),
                              decelerationCurve: Curves.easeOut,
                              pauseAfterRound: Duration(seconds: 7),
                              startAfter: Duration(seconds: 7),
                            )
                          : Text(
                              _songName,
                              style: GoogleFonts.redHatDisplay(
                                  color: _whiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                      subtitle: _songArtist.length >= 30
                          ? Marquee(
                              showFadingOnlyWhenScrolling: true,
                              text: _songArtist,
                              style: GoogleFonts.redHatDisplay(
                                  color: _darkGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 10.0,
                              velocity: 50.0,
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                              textDirection: TextDirection.ltr,
                              pauseAfterRound: const Duration(seconds: 10),
                              startAfter: const Duration(seconds: 7),
                            )
                          : Text(
                              _songArtist,
                              style: GoogleFonts.redHatDisplay(
                                  color: _darkGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                      contentPadding: EdgeInsets.all(3),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                            _isLiked
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: _isLiked ? _purpleColor : _whiteColor,
                            size: 30),
                        color: _whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<MusicPlayerProvider>(
            builder: (context, provider, child) {
              return SizedBox(
                width: 330,
                child: StreamBuilder<Playing?>(
                  stream: provider.player.current,
                  builder: (context, snapshot) {
                    final playing = snapshot.data;
                    final duration = playing?.audio.duration ?? Duration.zero;

                    return StreamBuilder<Duration>(
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
          Consumer<MusicPlayerProvider>(builder: (context, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.lyrics,
                      color: whiteColor,
                    )),
                IconButton(
                  onPressed: () async {
                    try {
                      // Ensure the player is playing or paused before seeking
                      if (provider.player.isPlaying.value ||
                          provider.player.isPlaying.value == false) {
                        var currentPosition =
                            provider.player.currentPosition.value;

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
                IconButton(
                  onPressed: () async {
                    provider.togglePlayPause();
                    if (provider.player.isPlaying.value == true) {
                      await provider.player.pause();
                    } else {
                      await provider.player.play();
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    provider.player.isPlaying.value
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 65,
                  ),
                  color: whiteColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next_rounded,
                    size: 55,
                  ),
                  color: whiteColor,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.queue_music,
                      color: whiteColor,
                    ))
              ],
            );
          }),
        ],
      ),
    );
  }
}
