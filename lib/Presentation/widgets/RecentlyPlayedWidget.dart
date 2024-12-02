import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/models/playlist_model.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';
import '../../Providers/recently_played_provider.dart';
import '../../models/song_model.dart';
import 'more_options_sheet.dart';

class PreviouslyPlayedCircleWidget extends StatelessWidget {
  const PreviouslyPlayedCircleWidget({super.key, required this.index});
  final int index;

  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the RecentlyPlayedProvider to access recently played songs
    var recentlyPlayedProvider =
        Provider.of<RecentlyPlayedProvider>(context, listen: false);

    // Ensure the index is within bounds
    if (index >= recentlyPlayedProvider.recentlyPlayedSongs.length) {
      return Center(
        child: Text(
          'No Data',
          style: TextStyle(color: whiteColor),
        ),
      );
    }

    // Get the recently played song data at the given index
    final recentlyPlayedSong =
        recentlyPlayedProvider.recentlyPlayedSongs.reversed.toList()[index];

    Song song = Song(
        imageUrl: recentlyPlayedSong.songImageUrl,
        songName: recentlyPlayedSong.songName,
        artists: recentlyPlayedSong.songArtists);

    PlaylistSongModel songModel = PlaylistSongModel(
        songName: recentlyPlayedSong.songName,
        songArtists: recentlyPlayedSong.songArtists,
        songImageUrl: recentlyPlayedSong.songImageUrl);

    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          useSafeArea: true,
          enableDrag: true,
          showDragHandle: true,
          backgroundColor: eerieblackColor,
          context: context,
          builder: (context) {
            return MoreOptionsSheet(song: songModel);
          },
        );
      },
      child: Bounceable(
        onTap: () => handleSongTap(context: context, song: song),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 13, right: 15, top: 10, bottom: 5),
              child: Container(
                height: 50,
                width: 90,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recentlyPlayedSong
                        .songImageUrl), // Using song's imageUrl
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: purpleColor,
                    ),
                    borderRadius: BorderRadius.circular(47),
                  ),
                ),
              ),
            ),
            Text(
              truncateText(
                  recentlyPlayedSong.songName, 15), // Using song's name
              style: GoogleFonts.redHatDisplay(
                fontSize: 11,
                color: whiteColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              truncateText(
                  recentlyPlayedSong.songArtists, 15), // Using song's artist
              style: GoogleFonts.redHatDisplay(
                fontSize: 10,
                color: darkgreyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
