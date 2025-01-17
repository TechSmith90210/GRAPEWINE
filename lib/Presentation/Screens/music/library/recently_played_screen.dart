import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Data/services/local_helper.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/AppBarWidget.dart';
import 'library_screen.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: 'Recently Played',
          // actions: [
          //   IconButton(icon: Icon(Icons.clear,color: greyColor,),onPressed: () {
          //     var provider  = Provider.of<RecentlyPlayedProvider>(context,listen: false);
          //     provider.clearRecentlyPlayed();
          //   },)
          // ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
        ),
        body: Consumer<RecentlyPlayedProvider>(
          builder: (context, recentProvider, child) {
            final songs = recentProvider.recentlyPlayedSongs.reversed.toList();
            return Container(
                margin: const EdgeInsets.only(bottom: 35),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: double.infinity,
                child: songs.isEmpty
                    ? Center(
                        child: Text(
                          'Listen to songs and check your history here',
                          style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 16),
                        itemBuilder: (context, index) {
                          final song = songs[index];
                          return buildSongTileWidget(
                            cx: context,
                            imageUrl: song.songImageUrl,
                            songTitle: song.songName,
                            songArtist: song.songArtists,
                            songId: song.songId
                          );
                        },
                        itemCount: songs.length,
                      ));
          },
        ));
  }
}
