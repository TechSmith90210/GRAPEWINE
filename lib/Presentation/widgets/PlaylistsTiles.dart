import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/playlist/play_playlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../../Colors/colors.dart';
import '../../Providers/playlist_provider.dart';
import '../../models/playlist.dart';
import '../../utlities/truncate_text.dart';

class PlaylistsWidget extends StatelessWidget {
  const PlaylistsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, provider, child) {
        if (provider.playlists.isEmpty) {
          return SizedBox(
            height: 180,
            child: Center(
                child: Text(
              'No Playlists yet',
              style: TextStyle(
                fontSize: 10,
                color: greyColor,
                // fontStyle: FontStyle.italic
              ),
            )),
          );
        }

        return SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.playlists.length,
            itemBuilder: (context, index) {
              Playlist playlist = provider.playlists[index];
              return PlaylistTile(playlist: playlist);
            },
          ),
        );
      },
    );
  }
}

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;

  const PlaylistTile({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PlaylistProvider>(context);
    return GestureDetector(
      onLongPress: () {
        provider.deletePlaylist(playlist.id, context);
      },
      child: Bounceable(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlayPlaylistScreen(playlist: playlist)));
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 13, right: 5, top: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(playlist.imageUrl!)) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                truncateText(playlist.playlistName, 13),
                style: GoogleFonts.redHatDisplay(
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Songs: ${playlist.songs.length}',
                style: GoogleFonts.redHatDisplay(
                  color: greyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
