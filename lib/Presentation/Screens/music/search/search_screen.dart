import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart'; // Import the Google Fonts package
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/TrendingItemWidget.dart';
import 'package:grapewine_music_app/models/song_model.dart';
import '../../../../Colors/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          title: 'SEARCH',
          // leading: ImageIcon(
          //   const AssetImage("assets/grapewine_logo_medium.png"),
          //   color: purpleColor,
          // ),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.only(right: 7),
          //     child: CircleAvatar(
          //       backgroundColor: Color(0xffE6E6E6),
          //       backgroundImage: NetworkImage(
          //           'https://i.pinimg.com/736x/3c/fe/f0/3cfef07dbfaea9c6229ec5eb4aa305e0.jpg'),
          //       // child: Icon(
          //       //   Icons.person,
          //       //   color: Color(0xffCCCCCC),
          //       // ),
          //     ),
          //   )
          // ],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SearchBarWidget(),
                const SizedBox(
                  height: 50,
                ),
                Bounceable(
                  onTap: () {
                    handleSongTap(
                        context: context,
                        song: Song(
                            imageUrl:
                                'https://i.scdn.co/image/ab67616d0000b273dca2deff544636f1ad1d9d96',
                            songName: 'FOREVER',
                            artists: 'Destroy Lonely'));
                  },
                  child: SizedBox(
                    height: 160,
                    width: 324,
                    child: Stack(
                      children: [
                        Container(
                          height: 115,
                          width: 324,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'New Album',
                                  style: GoogleFonts.redHatDisplay(
                                    color: greyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Love Lost\nForever',
                                  style: GoogleFonts.redHatDisplay(
                                    color: yellowColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  'Destroy Lonely',
                                  style: GoogleFonts.redHatDisplay(
                                    color: whiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(175,
                              -36), // Adjust this value to move the image up
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b273dca2deff544636f1ad1d9d96',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Trending',
                      style: GoogleFonts.redHatDisplay(
                          color: greenColor, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const TrendingSongsScrollableList(),
              ],
            ),
          ),
        ));
  }
}
