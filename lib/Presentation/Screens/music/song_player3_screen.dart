import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/CustomStrings.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/queue_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/more_options_sheet.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/liked_songs.dart';
import 'package:grapewine_music_app/models/playlist.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../../../Providers/musicPlayer_provider.dart';
import '../../../models/song_model.dart';
import '../../../utlities/truncate_text.dart';

class SongPlayer3Screen extends StatefulWidget {
  @override
  _SongPlayer3ScreenState createState() => _SongPlayer3ScreenState();
}

class _SongPlayer3ScreenState extends State<SongPlayer3Screen> {
  Color _whiteColor = Colors.white;
  Color _darkGreyColor = Colors.grey;

  Future<void> _initialize() async {
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    var recentProvider =
        Provider.of<RecentlyPlayedProvider>(context, listen: false);

    if (!musicPlayerProvider.firstSongRun &&
        !musicPlayerProvider.isInitialized &&
        !musicPlayerProvider.player.isPlaying.value) {
      musicPlayerProvider.setFirstSongRun();
      musicPlayerProvider.setInitialization();
      if (searchProvider.selectedSongName != "Unknown Song") {
        await musicPlayerProvider.fetchSong(
            searchProvider.selectedSongName, searchProvider);
      }
    }
  }

  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = _initialize();
  }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context);
    var musicPlayerProvider = Provider.of<MusicPlayerProvider>(context);

    String songName = searchProvider.selectedSongName;
    String songArtist = searchProvider.selectedSongArtist;
    String songImageUrl = searchProvider.selectedSongImage;
    String songId = searchProvider.selectedSongId;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    truncateText(songName, 50),
                    style: GoogleFonts.redHatDisplay(
                        color: yellowColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.keyboard_arrow_down_rounded),
              //   color: greyColor,
              // ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      useSafeArea: true,
                      enableDrag: true,
                      showDragHandle: true,
                      backgroundColor: eerieblackColor,
                      context: context,
                      builder: (context) {
                        return MoreOptionsSheet(
                            song: PlaylistSong(
                              songId: songId,
                                songName: songName,
                                songArtists: songArtist,
                                songImageUrl: songImageUrl));
                      },
                    );
                  },
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: whiteColor,
                  ))
            ],
          ),
          SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(songImageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(11)),
              ),
              ListTile(
                  title: SizedBox(
                    height: 30,
                    width: 180,
                    child: songName.length >= 20
                        ? Marquee(
                            showFadingOnlyWhenScrolling: true,
                            text: songName,
                            style: GoogleFonts.redHatDisplay(
                                color: _whiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 8.0,
                            velocity: 50.0,
                            accelerationDuration: const Duration(seconds: 2),
                            accelerationCurve: Curves.linear,
                            decelerationDuration: Duration(milliseconds: 0),
                            decelerationCurve: Curves.easeOut,
                            pauseAfterRound: Duration(seconds: 7),
                            startAfter: Duration(seconds: 7),
                          )
                        : Text(
                            songName,
                            style: GoogleFonts.redHatDisplay(
                                color: _whiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                  ),
                  subtitle: Container(
                    height: 20,
                    width: 140,
                    child: songArtist.length >= 60
                        ? Marquee(
                            showFadingOnlyWhenScrolling: true,
                            text: songArtist,
                            style: GoogleFonts.redHatDisplay(
                                color: _darkGreyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 15.0,
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
                            songArtist,
                            style: GoogleFonts.redHatDisplay(
                                color: _darkGreyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                  contentPadding: const EdgeInsets.all(3),
                  trailing: Consumer<LikedProvider>(
                    builder: (context, value, child) {
                      LikedSongs song = LikedSongs()
                        ..songName = songName
                        ..songArtists = songArtist
                        ..songImageUrl = songImageUrl
                        ..songDuration = musicPlayerProvider
                                .player.current.valueOrNull?.audio.duration
                                .toString() ??
                            Duration.zero.toString()
                        ..likedAt = DateTime.now()
                      ..songId =songId
                      ;
                      var isLiked = value.isLiked(song);
                      return IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? purpleColor : greyColor,
                        ),
                        onPressed: () {
                          value.toggleLike(song);
                        },
                      );
                    },
                  ))
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 330,
            child: StreamBuilder<Playing?>(
              stream: musicPlayerProvider.player.current,
              builder: (context, snapshot) {
                final playing = snapshot.data;
                final duration = playing?.audio.duration ?? Duration.zero;

                return StreamBuilder<Duration>(
                  stream: musicPlayerProvider.player.currentPosition,
                  builder: (context, positionSnapshot) {
                    final position = positionSnapshot.data ?? Duration.zero;
                    musicPlayerProvider.player.playlistAudioFinished.listen(
                      (Playing playing) {},
                      onDone: () {
                        musicPlayerProvider.player.next(stopIfLast: true);
                      },
                    );

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
                        musicPlayerProvider.player.seek(newPosition);
                        print('Player seeked to $newPosition');
                      },
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LyricsScreen(
                  //         songName: songName,
                  //         songArtist: songArtist,
                  //       ),
                  //     ));
                },
                icon: Icon(
                  Icons.lyrics_outlined,
                  color: whiteColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  try {
                    final musicProvider = Provider.of<MusicPlayerProvider>(
                        context,
                        listen: false);
                    final searchProvider =
                        Provider.of<SearchProvider>(context, listen: false);

                    // Call handleNextAction
                    musicProvider.handlePrevAction(
                        musicProvider.player, searchProvider);
                  } catch (e) {
                    print('Error playing previous song: $e');
                  }
                },
                icon: const Icon(
                  Icons.skip_previous_rounded,
                  size: 55,
                ),
                color: whiteColor,
              ),
              IconButton(
                onPressed: () async {
                  musicPlayerProvider.togglePlayPause();
                  if (musicPlayerProvider.player.isPlaying.valueOrNull ==
                      true) {
                    await musicPlayerProvider.player.pause();
                  } else {
                    await musicPlayerProvider.player.play();
                  }
                  setState(() {});
                },
                icon: Icon(
                  musicPlayerProvider.player.isPlaying.valueOrNull == true
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  size: 65,
                ),
                color: whiteColor,
              ),
              IconButton(
                onPressed: () {
                  final musicProvider =
                      Provider.of<MusicPlayerProvider>(context, listen: false);
                  final searchProvider =
                      Provider.of<SearchProvider>(context, listen: false);
                  final recentProvider = Provider.of<RecentlyPlayedProvider>(
                      context,
                      listen: false);

                  // Call handleNextAction
                  musicProvider.handleNextAction(
                      musicProvider.player, searchProvider, recentProvider);
                },
                icon: const Icon(
                  Icons.skip_next_rounded,
                  size: 55,
                ),
                color: whiteColor,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QueueScreen(),
                      ));
                },
                icon: Icon(
                  Icons.queue_music,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
