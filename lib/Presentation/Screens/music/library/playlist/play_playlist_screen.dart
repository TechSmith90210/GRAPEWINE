import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';
import 'package:provider/provider.dart';

import '../../../../../Colors/colors.dart';
import '../../../../../models/song_model.dart';
import '../../../../widgets/more_options_sheet.dart';

class PlayPlaylistScreen extends StatelessWidget {
  final PlaylistModel playlist;
  const PlayPlaylistScreen({super.key, required this.playlist});

  // Helper function to map PlaylistSongModel to Song
  List<Song> mapPlaylistSongsToSongs(List<PlaylistSongModel> playlistSongs) {
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
              return Consumer<PlaylistProvider>(
                builder: (context, playlistProvider, child) {
                  bool isEditing = playlistProvider.isEditing;

                  return Row(
                    children: isEditing
                        ? [
                            // Delete playlist button
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors
                                        .black, // Black background for the dialog
                                    title: const Text(
                                      'Delete Playlist',
                                      style: TextStyle(
                                          color: Colors
                                              .white), // White text for the title
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete this playlist?',
                                      style: TextStyle(
                                          color: Colors
                                              .white70), // Lighter text for content
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors
                                                  .white), // White text for 'Cancel'
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(
                                              context); // Close dialog
                                          Navigator.pop(context); // Exit screen
                                          Future.delayed(
                                            const Duration(seconds: 1),
                                            () {
                                              playlistProvider
                                                  .deletePlaylist(playlist.id!);
                                            },
                                          );
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors
                                                  .red), // Red color for the 'Delete' action
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
                                // Handle save logic if needed
                              },
                              icon: const Icon(Icons.check),
                              color: whiteColor,
                            ),
                          ]
                        : [
                            // Enter edit mode button
                            IconButton(
                              onPressed: () =>
                                  playlistProvider.setEditing(true),
                              icon: const Icon(Icons.edit_outlined),
                              color: whiteColor,
                            ),
                          ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer2<PlaylistProvider, MusicPlayerProvider>(
        builder: (context, playlistProvider, musicPlayerProvider, child) {
          final updatedPlaylist =
              playlistProvider.getPlaylistById(playlist.id!);

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
                        // If a song is already playing, pause it
                        if (musicPlayerProvider.player.isPlaying.value) {
                          await musicPlayerProvider.player.pause();
                        } else {
                          // Map playlist songs to Song model and play them
                          List<Song> songs =
                              mapPlaylistSongsToSongs(updatedPlaylist.songs);
                          handlePlaylistTap(
                            context: context,
                            playlist: songs,
                          );
                          print('Playing playlist');
                        }
                      },
                      icon: Icon(
                        musicPlayerProvider.player.isPlaying.value
                            ? Icons.pause_outlined
                            : Icons.play_arrow_outlined,
                        size: 30,
                      ),
                      color: blackColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: updatedPlaylist.songs.isNotEmpty
                    ? ListView.builder(
                        itemCount: updatedPlaylist.songs.length,
                        itemBuilder: (context, index) {
                          final song = updatedPlaylist.songs[index];
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
                                        updatedPlaylist.id!,
                                        index,
                                      );
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
                                  // Handle song tap (you can play this specific song here)
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
                                    playlistProvider.isEditing
                                        ? {
                                            playlistProvider
                                                .removeSongFromPlaylist(
                                              updatedPlaylist.id!,
                                              index,
                                            )
                                          }
                                        : showModalBottomSheet(
                                            useSafeArea: true,
                                            enableDrag: true,
                                            showDragHandle: true,
                                            backgroundColor: eerieblackColor,
                                            context: context,
                                            builder: (context) {
                                              return MoreOptionsSheet(
                                                  song: PlaylistSongModel(
                                                      songName: song.songName,
                                                      songArtists:
                                                          song.songArtists,
                                                      songImageUrl:
                                                          song.songImageUrl));
                                            },
                                          );
                                  },
                                  icon: Icon(playlistProvider.isEditing
                                      ? Icons.close
                                      : Icons.more_horiz),
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No songs in this playlist.',
                          style: GoogleFonts.redHatDisplay(
                            color: whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
