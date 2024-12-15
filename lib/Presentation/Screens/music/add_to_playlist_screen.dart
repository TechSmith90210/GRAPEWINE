import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/playlist/create_playlist_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';
import 'package:provider/provider.dart';

import '../../../Colors/colors.dart';

class AddToPlaylistScreen extends StatelessWidget {
  final PlaylistSongModel playlistSongModel;
  const AddToPlaylistScreen({super.key, required this.playlistSongModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Add to Playlists',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePlaylistScreen(),
                  ));
            },
            icon: Icon(Icons.add_circle_outline),
            color: whiteColor,
            tooltip: 'Create New Playlist',
          )
        ],
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final playlists = value.playlists;

          // If there are no playlists, display a message
          if (playlists.isEmpty) {
            return Center(
              child: Text(
                'No playlists available',
                style: TextStyle(color: greyColor),
              ),
            );
          }

          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              final imageUrl = playlist.imageUrl.toString();

              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: imageUrl.isNotEmpty
                          ? FileImage(File(imageUrl)) as ImageProvider
                          : const NetworkImage(
                              'https://assets.audiomack.com/default-song-image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  playlist
                      .playlistName, // Assuming playlist has a name property
                  style: TextStyle(color: whiteColor),
                ),
                onTap: () {
                  value.addSongToPlaylist(playlist.id!, playlistSongModel);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
