import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Navbar%20Screens/liked_songs_screen.dart';
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
        actions: const [
          CircleAvatar(
            backgroundColor: Color(0xffE6E6E6),
            backgroundImage: AssetImage('assets/professor x pfp.jpg'),
            radius: 30,
            // child: Icon(
            //   Icons.person,
            //   color: Color(0xffCCCCCC),
            // ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LikedSongsScreen(),));
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
              ))
        ],
      ),
    );
  }
}
