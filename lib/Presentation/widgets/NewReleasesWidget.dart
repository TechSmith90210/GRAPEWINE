import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:grapewine_music_app/models/song_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../Screens/music/library/liked_songs_screen.dart';
import 'MiniPlayerWidget.dart';

class NewReleasesWidget extends StatelessWidget {
  const NewReleasesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewReleasesProvider>(
      builder: (context, provider, child) {
        // Ensure data is available
        if (provider.realalbumNames.isEmpty ||
            provider.realalbumCovers.isEmpty ||
            provider.allAlbumArtists.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: purpleColor,
            ),
          );
        }

        return SizedBox(
          height: 180, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.realalbumNames.length,
            itemBuilder: (context, index) {
              // Create a song object
              Song song = Song(
                imageUrl: provider.realalbumCovers[index].toString(),
                songName: provider.realalbumNames[index].toString(),
                artists: provider.allAlbumArtists[index].toString(),
              );

              // Return the custom tile widget for each song
              return NewReleaseTile(song: song);
            },
          ),
        );
      },
    );
  }
}

class NewReleaseTile extends StatelessWidget {
  final Song song;

  const NewReleaseTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Handle long press if necessary
      },
      child: Bounceable(
        onTap: () {
          handleSongTap(context: context, song: song);
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
                    image: NetworkImage(song.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                truncateText(song.songName, 13),
                style: GoogleFonts.redHatDisplay(
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                truncateText(song.artists, 17),
                style: GoogleFonts.redHatDisplay(
                  color: greyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
