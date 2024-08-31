import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/Navbar%20Screens/liked_songs_screen.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:grapewine_music_app/models/song_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'MiniPlayerWidget.dart';

class NewReleasesWidget extends StatefulWidget {
  final int index;

  const NewReleasesWidget({super.key, required this.index});

  @override
  State<NewReleasesWidget> createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget>
    with AutomaticKeepAliveClientMixin<NewReleasesWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<NewReleasesProvider>(
      builder: (context, provider, child) {
        // Ensure data is available
        if (provider.albumNames.isEmpty ||
            provider.albumCovers.isEmpty ||
            provider.albumArtists.isEmpty) {
          // Return a placeholder or loading indicator while data is being fetched
          return Center(
            child: CircularProgressIndicator(
              color: purpleColor,
            ),
          );
        }

        return Bounceable(
          onTap: () {
            Song song = Song(
                imageUrl: provider.albumCovers[widget.index].toString(),
                songName: provider.albumNames[widget.index].toString(),
                artists: provider.albumArtists[widget.index].toString());
            handleSongTap(context: context, song: song);
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
                      image: NetworkImage(
                        provider.albumCovers[widget.index].toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 8), // Space between cover and text
                Text(
                  truncateText(
                      provider.albumNames[widget.index].toString(), 13),
                  style: GoogleFonts.redHatDisplay(
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis, // Handle overflow
                ),
                const SizedBox(height: 4), // Space between name and artist
                Text(
                  truncateText(
                      provider.albumArtists[widget.index].toString(), 17),
                  style: GoogleFonts.redHatDisplay(
                    color: greyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis, // Handle overflow
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
