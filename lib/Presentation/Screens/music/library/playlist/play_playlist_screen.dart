import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../Colors/colors.dart';
import '../../../../../Providers/musicPlayer_provider.dart';
import '../../../../../Providers/playlist_provider.dart';
import '../../../../../models/playlist.dart';
import '../../../../../models/song_model.dart';
import '../../../../widgets/more_options_sheet.dart';
import '../liked_songs_screen.dart';

class PlayPlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  const PlayPlaylistScreen({super.key, required this.playlist});

  List<Song> mapPlaylistSongsToSongs(List<PlaylistSong> playlistSongs) {
    return playlistSongs.map((playlistSong) {
      return Song(
        songName: playlistSong.songName,
        artists: playlistSong.songArtists,
        imageUrl: playlistSong.songImageUrl,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var playlistProvider = Provider.of<PlaylistProvider>(context);
    var musicProvider = Provider.of<MusicPlayerProvider>(context);

    return Scaffold(
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          final updatedPlaylist = playlistProvider.getPlaylistById(playlist.id);
          List<PlaylistSong> songs = updatedPlaylist.songs.toList();
          final playlistSongs = mapPlaylistSongsToSongs(songs);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  playlist.playlistName,
                  style: GoogleFonts.redHatDisplay(
                      color: redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                foregroundColor: whiteColor,
                actions: [
                  Builder(
                    builder: (context) {
                      return playlistProvider.isEditing
                          ? Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.black,
                                        title: const Text(
                                          'Delete Playlist',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to delete this playlist?',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              playlistProvider
                                                  .setEditing(false);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 300));
                                              playlistProvider.deletePlaylist(
                                                  playlist.id, context);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                  color: whiteColor,
                                ),
                                IconButton(
                                  onPressed: () {
                                    playlistProvider.setEditing(false);
                                  },
                                  icon: const Icon(Icons.check),
                                  color: whiteColor,
                                ),
                              ],
                            )
                          : IconButton(
                              onPressed: () =>
                                  playlistProvider.setEditing(true),
                              icon: const Icon(Icons.edit_outlined),
                              color: whiteColor,
                            );
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      if (musicProvider.player.isPlaying.value) {
                        await musicProvider.player.pause();
                      }
                      // Handle playlist play
                      handlePlaylistTap(
                          context: context, playlist: playlistSongs);
                    },
                    icon: Icon(
                      musicProvider.player.isPlaying.value
                          ? Icons.pause_outlined
                          : Icons.play_arrow_outlined,
                      size: 20,
                    ),
                    color: whiteColor,
                  ),
                ],
                expandedHeight: 300.0,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: playlist.imageUrl != null
                                ? FileImage(File(playlist.imageUrl!))
                                : const NetworkImage(
                                        'https://assets.audiomack.com/default-song-image.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      playlist.playlistName,
                                      style: GoogleFonts.redHatDisplay(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${playlist.songs.length} songs',
                                      style: GoogleFonts.redHatDisplay(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: redColor,
                                  minimumSize: const Size(50, 50),
                                ),
                                onPressed: () async {
                                  if (musicProvider.player.isPlaying.value) {
                                    await musicProvider.player.pause();
                                  }
                                  // Handle playlist play
                                  handlePlaylistTap(
                                      context: context,
                                      playlist: playlistSongs);
                                },
                                icon: Icon(
                                  musicProvider.player.isPlaying.value
                                      ? Icons.pause_outlined
                                      : Icons.play_arrow_outlined,
                                  size: 30,
                                ),
                                color: whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              autoClose: true,
                              onPressed: (context) {
                                playlistProvider.removeSongFromPlaylist(
                                    updatedPlaylist.id, index);
                              },
                              backgroundColor: redColor,
                              foregroundColor: Colors.white,
                              icon: Icons.playlist_remove,
                              label: 'Remove',
                            ),
                          ],
                        ),
                        child: ListTile(
                          tileColor: blackColor.withOpacity(0.2),
                          onTap: () {
                            handlePlaylistTap(
                              context: context,
                              playlist: mapPlaylistSongsToSongs(
                                  updatedPlaylist.songs.toList()),
                              index: index,
                            );
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
                            style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            song.songArtists,
                            style: GoogleFonts.redHatDisplay(
                              color: darkgreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              playlistProvider.isEditing
                                  ? playlistProvider.removeSongFromPlaylist(
                                      updatedPlaylist.id, index)
                                  : showModalBottomSheet(
                                      backgroundColor: eerieblackColor,
                                      context: context,
                                      builder: (context) {
                                        return MoreOptionsSheet(
                                          song: PlaylistSong(
                                            songName: song.songName,
                                            songArtists: song.songArtists,
                                            songImageUrl: song.songImageUrl,
                                          ),
                                        );
                                      },
                                    );
                            },
                            icon: Icon(
                              playlistProvider.isEditing
                                  ? Icons.close
                                  : Icons.more_horiz,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: songs.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
