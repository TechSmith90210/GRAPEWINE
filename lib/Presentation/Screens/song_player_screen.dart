import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/widgets/ArtistChipsWidget.dart';

import '../../Colors/colors.dart';

class SongPlayerScreen extends StatefulWidget {
  const SongPlayerScreen({super.key});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkblueBubbleColor,
        body: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Now Playing',
                    style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'At The Party',
                    style: GoogleFonts.redHatDisplay(
                        color: yellowColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 60,
                    color: darkgreyColor,
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.universalmusic.ca/wp-content/uploads/2023/11/AtTheParty-Single-Artwork_FINAL-scaled.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(11)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.textsms_outlined,
                        color: whiteColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        children: [
                          Text(
                            'At The Party',
                            style: GoogleFonts.redHatDisplay(
                                color: whiteColor,
                                fontSize: 28,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Kid Cudi, Pharell Williams, Travis Scott',
                            style: GoogleFonts.redHatDisplay(
                                color: darkgreyColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Icon(
                        Icons.favorite_border_rounded,
                        color: whiteColor,
                        size: 30,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
