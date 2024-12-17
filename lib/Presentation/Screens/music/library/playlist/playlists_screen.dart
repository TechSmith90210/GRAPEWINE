import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/playlist/create_playlist_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/playlist/play_playlist_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../../../../models/playlist.dart'; // Import for File

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: whiteColor,
        ),
        title: 'Playlists',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePlaylistScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add_circle_outline_rounded),
            color: greyColor,
          )
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final playlists = value.playlists;

          return playlists.isNotEmpty
              ? GridView.builder(
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return PlaylistSongTileWidget(
                      playlistName: playlist.playlistName,
                      imageUrl: playlist.imageUrl.toString(),
                      playlistModel: playlist,
                    );
                  },
                  itemCount: playlists.length,
                )
              : Center(
                  child: Text(
                    'No Playlists',
                    style: GoogleFonts.redHatDisplay(color: whiteColor),
                  ),
                );
        },
      ),
    );
  }
}

class PlaylistSongTileWidget extends StatelessWidget {
  final String playlistName;
  final String imageUrl;
  final Playlist playlistModel;
  const PlaylistSongTileWidget(
      {super.key,
      required this.playlistName,
      required this.imageUrl,
      required this.playlistModel});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayPlaylistScreen(playlist: playlistModel),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 13, right: 5, top: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageUrl.isNotEmpty
                      ? FileImage(File(imageUrl))
                      : const NetworkImage(
                              'https://assets.audiomack.com/default-song-image.png')
                          as ImageProvider, // Placeholder asset image
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 8), // Space between cover and text
            Text(
              playlistName, // Use the playlistName passed in
              style: GoogleFonts.redHatDisplay(
                color: whiteColor,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis, // Handle overflow
            ),
          ],
        ),
      ),
    );
  }
}
