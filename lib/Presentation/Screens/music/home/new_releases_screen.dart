import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:grapewine_music_app/models/song_model.dart';
import 'package:provider/provider.dart';

import '../../../widgets/NewReleasesWidget.dart';

class NewReleasesScreen extends StatelessWidget {
  const NewReleasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "New Releases",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: Consumer<NewReleasesProvider>(
        builder: (context, provider, child) {
          // Check if data is loaded
          if (provider.realalbumNames.isEmpty ||
              provider.realalbumCovers.isEmpty ||
              provider.allAlbumArtists.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: purpleColor,
              ),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 2 items per row
              childAspectRatio: 0.7, // Aspect ratio of each item
              mainAxisSpacing: 6, // Vertical space between items
              crossAxisSpacing: 16, // Horizontal space between items
            ),
            itemCount: provider.realalbumNames.length,
            itemBuilder: (context, index) {
              Song song = Song(
                imageUrl: provider.realalbumCovers[index].toString(),
                songName: provider.realalbumNames[index].toString(),
                artists: provider.allAlbumArtists[index].toString(),
              );
              return NewReleaseTile(song: song); // Display each new release
            },
          );
        },
      ),
    );
  }
}
