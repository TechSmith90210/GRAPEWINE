import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/playlists_screen.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:provider/provider.dart';
import '../../Providers/like_provider.dart';
import '../../models/song_model.dart';
import '../Navbar Screens/liked_songs_screen.dart';
import '../Screens/recently_played_screen.dart';
import '../widgets/AppBarWidget.dart';
import '../../Colors/colors.dart';
import '../widgets/MiniPlayerWidget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'LIBRARY',
        leading: ImageIcon(
          const AssetImage("assets/grapewine logo medium.png"),
          color: purpleColor,
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 7),
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/3c/fe/f0/3cfef07dbfaea9c6229ec5eb4aa305e0.jpg'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
                color: blackColor,
                border: Border.symmetric(
                    horizontal: BorderSide(color: greyColor, width: 0.4))),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  splashColor: whiteColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LikedSongsScreen(),
                        ));
                  },
                  title: Text(
                    'Liked Songs',
                    style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                  leading: Icon(
                    Icons.favorite_border,
                    color: whiteColor,
                  ),
                  trailing: Consumer<LikedProvider>(
                    builder: (context, likedProvider, child) {
                      final count = likedProvider.likedSongs.length;
                      return Text(
                        '$count', // Display the liked songs count
                        style: GoogleFonts.redHatDisplay(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  color: greyColor,
                  thickness: 0.4,
                  indent: 55,
                  height: 1,
                ),
                ListTile(
                  splashColor: greyColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaylistsScreen(),
                        ));
                  },
                  title: Text(
                    'Playlists',
                    style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                  leading: Icon(
                    Icons.queue_music,
                    color: whiteColor,
                  ),
                  trailing: Consumer<PlaylistProvider>(
                    builder: (context, playlistProvider, child) {
                      return Text(
                        playlistProvider.playlists.length.toString(),
                        style: GoogleFonts.redHatDisplay(
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recently Played',
                      style: GoogleFonts.redHatDisplay(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecentlyPlayedScreen(),
                            ));
                      },
                      child: Text(
                        'View All',
                        style: GoogleFonts.redHatDisplay(
                            color: redColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<RecentlyPlayedProvider>(
                builder: (context, recentProvider, child) {
                  final songs =
                      recentProvider.recentlyPlayedSongs.reversed.toList();
                  return Container(
                    margin: const EdgeInsets.only(bottom: 35),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    height: 340,
                    child: songs.isEmpty
                        ? Center(
                            child: Text(
                              'Listen to songs and check your history here',
                              style: GoogleFonts.redHatDisplay(
                                  color: whiteColor,
                                  fontSize: 12,
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
                              );
                            },
                            itemCount: songs.length < 6 ? songs.length : 6,
                          ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildSongTileWidget({
  required String imageUrl,
  required String songTitle,
  required String songArtist,
  required BuildContext cx,
}) {
  return Bounceable(
    onTap: () {
      handleSongTap(
        context: cx,
        song: Song(
          imageUrl: imageUrl,
          songName: songTitle,
          artists: songArtist,
        ),
      );
    },
    child: SizedBox(
      width: 120, // Adjust width to fit within the grid
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100, // Ensure width matches the SizedBox
            decoration: BoxDecoration(
              color: blackColor,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover, // Ensure the image fits within the container
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 8), // Add spacing between image and text
          Text(
            truncateText(songTitle, 14),
            style: GoogleFonts.redHatDisplay(
              color: whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            truncateText(songArtist, 16),
            style: GoogleFonts.redHatDisplay(
              color: greyColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
