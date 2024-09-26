import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/add_to_playlist_screen.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';
import '../../models/song_model.dart';
import 'MiniPlayerWidget.dart'; // Adjust this import based on your project structure

class MoreOptionsSheet extends StatelessWidget {
  final Song song;

  const MoreOptionsSheet({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    // List of options for the bottom sheet
    final List<Map<String, dynamic>> options = [
      {
        'icon': Icons.add_circle_outline_rounded,
        'title': 'Add to Playlist',
        'onTap': () {
          var fetchProvider =
              Provider.of<SearchProvider>(context, listen: false);
          PlaylistSongModel playlistSong = PlaylistSongModel(
              songName: fetchProvider.selectedSongName,
              songArtists: fetchProvider.selectedSongArtist,
              songImageUrl: fetchProvider.selectedSongImage);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddToPlaylistScreen(
                  playlistSongModel: playlistSong,
                ),
              ));
        },
      },
      {
        'icon': Icons.file_download,
        'title': 'Download',
        'onTap': () {
          // Handle Download action
        },
      },
    ];

    return ListView.separated(
      itemCount: options.length + 1, // Adjust to account for only song details
      separatorBuilder: (context, index) => Divider(
        color: greyColor,
        thickness: 0.3,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          // Song Details
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(image: NetworkImage(song.imageUrl)),
              ),
            ),
            title: Text(
              truncateText(song.songName, 15),
              style: GoogleFonts.redHatDisplay(color: whiteColor),
            ),
            subtitle: Text(
              truncateText(song.artists, 40),
              style: GoogleFonts.redHatDisplay(color: greyColor),
            ),
          );
        } else {
          final option = options[index - 1]; // Adjust index for options
          return Bounceable(
            onTap: option['onTap'],
            child: ListTile(
              leading: Icon(
                option['icon'],
                color: greyColor,
              ),
              title: Text(
                option['title'],
                style: GoogleFonts.redHatDisplay(
                  color: whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
