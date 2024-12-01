import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';
import 'package:provider/provider.dart';

import '../../../../../Colors/colors.dart';
import '../../../../../models/song_model.dart';

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
    return Scaffold(
      appBar: AppBarWidget(
        title: playlist.playlistName,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: whiteColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle editing the playlist
            },
            icon: const Icon(Icons.edit_outlined),
            color: whiteColor,
          )
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final updatedPlaylist = value.getPlaylistById(playlist.id!);

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
                    Text(
                      updatedPlaylist.playlistName,
                      style: GoogleFonts.redHatDisplay(
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 27),
                    ),
                    IconButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          minimumSize: const Size(50, 50)),
                      onPressed: () {
                        // Handle playlist play action
                        List<Song> songs = mapPlaylistSongsToSongs(updatedPlaylist.songs);
                        handlePlaylistTap(context: context, playlist: songs);
                        print('Playing playlist');
                      },
                      icon: const Icon(
                        Icons.play_arrow_outlined,
                        size: 30,
                      ),
                      color: blackColor,
                    )
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
                                value.removeSongFromPlaylist(
                                    updatedPlaylist.id!, index);
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
                              // Handle more actions here
                            },
                            icon: const Icon(Icons.more_horiz),
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
