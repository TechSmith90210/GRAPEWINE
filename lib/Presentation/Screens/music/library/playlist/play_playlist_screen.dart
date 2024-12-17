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
import '../../../../widgets/AppBarWidget.dart';
import '../../../../widgets/more_options_sheet.dart';
import '../liked_songs_screen.dart';

class PlayPlaylistScreen extends StatelessWidget {
  final Playlist playlist;
  const PlayPlaylistScreen({super.key, required this.playlist});

  // Helper function to map PlaylistSongModel to Song
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
    var imageUrl = playlist.imageUrl;
    var musicProvider = Provider.of<MusicPlayerProvider>(context);
    var playlistProvider = Provider.of<PlaylistProvider>(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: playlist.playlistName,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: whiteColor,
        ),
        actions: [
          Builder(
            builder: (context) {
              return Row(
                children: playlistProvider.isEditing
                    ? [
                        // Delete playlist button
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
                                  style: TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      playlistProvider
                                          .deletePlaylist(playlist.id);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete_outline),
                          color: whiteColor,
                        ),
                        // Save changes button
                        IconButton(
                          onPressed: () {
                            playlistProvider.setEditing(false);
                          },
                          icon: const Icon(Icons.check),
                          color: whiteColor,
                        ),
                      ]
                    : [
                        // Enter edit mode button
                        IconButton(
                          onPressed: () => playlistProvider.setEditing(true),
                          icon: const Icon(Icons.edit_outlined),
                          color: whiteColor,
                        ),
                      ],
              );
            },
          ),
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          // Load the playlist data
          final updatedPlaylist = playlistProvider.getPlaylistById(playlist.id);
          List<PlaylistSong> songs = updatedPlaylist.songs.toList();
          final playlistSongs = mapPlaylistSongsToSongs(songs);

          return Column(
            children: [
              Center(
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageUrl != null
                          ? FileImage(File(imageUrl))
                          : const NetworkImage(
                                  'https://assets.audiomack.com/default-song-image.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        updatedPlaylist.playlistName,
                        style: GoogleFonts.redHatDisplay(
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        softWrap: true,
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
                            context: context, playlist: playlistSongs);
                      },
                      icon: Icon(
                        musicProvider.player.isPlaying.value
                            ? Icons.pause_outlined
                            : Icons.play_arrow_outlined,
                        size: 30,
                      ),
                      color: whiteColor,
                    )
                  ],
                ),
              ),
              Expanded(
                child: updatedPlaylist.songs.toList().isEmpty
                    ? Center(
                  child: Text(
                    'No songs in this playlist.',
                    style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: updatedPlaylist.songs.length,
                  itemBuilder: (context, index) {
                    final play =  updatedPlaylist.songs.toList();
                    final song = play[index];
                    final thePlaylist = mapPlaylistSongsToSongs(updatedPlaylist.songs.toList());

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
                                playlistProvider.removeSongFromPlaylist(updatedPlaylist.id, index);
                              },
                              backgroundColor: redColor,
                              foregroundColor: Colors.white,
                              icon: Icons.playlist_remove,
                              label: 'Remove from playlist',
                            ),
                          ],
                        ),
                        child: ListTile(
                          tileColor: blackColor.withOpacity(0.2),
                          onTap: () {
                            handlePlaylistTap(
                              context: context,
                              playlist: thePlaylist,
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
                                  ? playlistProvider.removeSongFromPlaylist(updatedPlaylist.id, index)
                                  : showModalBottomSheet(backgroundColor: eerieblackColor,
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
                              playlistProvider.isEditing ? Icons.close : Icons.more_horiz,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
