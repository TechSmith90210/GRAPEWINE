import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Navbar%20Screens/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/MiniPlayerWidget.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';
import '../widgets/AppBarWidget.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var likeProvider = Provider.of<LikedProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'LIBRARY',
        leading: ImageIcon(
          const AssetImage("assets/grapewine logo medium.png"),
          color: purpleColor,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 7),
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/3c/fe/f0/3cfef07dbfaea9c6229ec5eb4aa305e0.jpg'),
              // child: Icon(
              //   Icons.person,
              //   color: Color(0xffCCCCCC),
              // ),
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
                    trailing: Text(
                      likeProvider.likedSongs.length.toString(),
                      style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
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
                    onTap: () {},
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
                    trailing: Text(
                      likeProvider.likedSongs.length.toString(),
                      style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                    onTap: () {},
                    child: Text(
                      'View All',
                      style: GoogleFonts.redHatDisplay(
                          color: redColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            ),
          ),
          Bounceable(
            onTap: () {},
            child: Container(
              height: 140,
              width: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: blackColor,
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da84f6dbbcc897f5d3b906bf98a7'),
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Text(
                    truncateText('Days Before Rodeo', 14),
                    style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Travis Scott',
                    style: GoogleFonts.redHatDisplay(
                      color: greyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
