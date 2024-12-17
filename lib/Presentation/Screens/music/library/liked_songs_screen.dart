import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/add_to_playlist_screen.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/models/playlist.dart';
import 'package:grapewine_music_app/models/recently_played.dart';
import 'package:provider/provider.dart';
import '../../../../Colors/colors.dart';
import '../../../../Providers/musicPlayer_provider.dart';
import '../../../../Providers/search_provider.dart';
import '../../../../models/song_model.dart';
import '../../../widgets/AppBarWidget.dart';

class LikedSongsScreen extends StatelessWidget {
  const LikedSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var recentProvider =
        Provider.of<RecentlyPlayedProvider>(context, listen: false);
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var musicPlayerProvider =
        Provider.of<MusicPlayerProvider>(context, listen: false);
    var likeProvider = Provider.of<LikedProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'LIKED SONGS',
        actions: [
          Consumer<LikedProvider>(
            builder: (context, likedProvider, child) {
              final count = likedProvider
                  .likedSongs.length; // Get the count of liked songs
              return Text(
                '$count',
                style: GoogleFonts.redHatDisplay(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              );
            },
          ),
          // IconButton(
          //   onPressed: () {
          //     final likeProvider =
          //         Provider.of<LikedProvider>(context, listen: false);
          //     likeProvider.clearLikedSongs(); // Clear liked songs
          //   },
          //   icon: Icon(Icons.delete),
          // ),

          IconButton(
            onPressed: () async {
              await likeProvider.playLikedSongs(
                  musicPlayerProvider, searchProvider, recentProvider);
            },
            icon: const Icon(Icons.play_arrow_rounded),
            color: whiteColor,
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: Consumer<LikedProvider>(
        builder: (context, likedProvider, child) {
          final likedSongs =
              likedProvider.likedSongs; // Access liked songs directly

          if (likedSongs.isEmpty) {
            return Center(
              child: Text(
                'No liked songs found',
                style: GoogleFonts.redHatDisplay(
                  color: whiteColor,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: likedSongs.length,
            itemBuilder: (context, index) {
              final allLikedSongs = likedSongs.reversed.toList();
              final song = allLikedSongs[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Slidable(
                  closeOnScroll: true,
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      autoClose: true,
                      onPressed: (context) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddToPlaylistScreen(
                                  playlistSongModel: PlaylistSong(
                                      songName: song.songName,
                                      songArtists: song.songArtists,
                                      songImageUrl: song.songImageUrl)),
                            ));
                      },
                      backgroundColor: linearColor1,
                      foregroundColor: Colors.white,
                      icon: Icons.playlist_add,
                      label: 'Add to playlist',
                    ),
                  ]),
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      autoClose: true,
                      onPressed: (context) =>
                          likedProvider.removeSongFromLiked(song),
                      backgroundColor: greyishColor,
                      foregroundColor: Colors.white,
                      icon: Icons.heart_broken,
                      label: 'Unlike',
                    ),
                  ]),
                  child: ListTile(
                    tileColor: blackColor.withOpacity(0.4),
                    onTap: () async {
                      // // Handle song tap
                      // handleSongTap(
                      //     context: context,
                      //     song: Song(
                      //         imageUrl: song.songImageUrl,
                      //         songName: song.songName,
                      //         artists: song.songArtists));
                      await likeProvider.playLikedSongsAtIndex(
                          musicPlayerProvider,
                          index,
                          searchProvider,
                          recentProvider);
                    },
                    leading: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            song.songImageUrl.isNotEmpty
                                ? song.songImageUrl
                                : 'https://assets.audiomack.com/default-song-image.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    title: Text(
                      song.songName,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      song.songArtists,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.redHatDisplay(
                        color: darkgreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        // Handle more actions here
                      },
                      icon: const Icon(Icons.more_horiz),
                      color: whiteColor,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
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
    ..playedAt = DateTime.now();

  searchProvider.setSongName(song.songName);
  searchProvider.setSongArtist(song.artists);
  searchProvider.setSongDetails(
      '${searchProvider.selectedSongName} ${searchProvider.selectedSongArtist} song audio');
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

void handlePlaylistTap(
    {required BuildContext context,
    required List<Song> playlist,
    int? index}) async {
  var searchProvider = Provider.of<SearchProvider>(context, listen: false);
  var musicPlayerProvider =
      Provider.of<MusicPlayerProvider>(context, listen: false);
  var recentProvider =
      Provider.of<RecentlyPlayedProvider>(context, listen: false);
  musicPlayerProvider.setFirstSongRun();
  await musicPlayerProvider
      .fetchPlaylist(playlist, searchProvider, recentProvider, index: index);
}
