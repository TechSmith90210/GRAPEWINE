import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';

class ArtistChipsWidget extends StatefulWidget {
  const ArtistChipsWidget({super.key});

  @override
  State<ArtistChipsWidget> createState() => _ArtistChipsWidgetState();
}

class _ArtistChipsWidgetState extends State<ArtistChipsWidget> {
  @override
  Widget build(BuildContext context) {
    var musicPlayerProvider = Provider.of<MusicPlayerProvider>(context);
    return Container(
      width: 370,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: musicPlayerProvider.artistImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 2),
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: ShapeDecoration(
                shape: StadiumBorder(
                  side: BorderSide(width: 0.1, color: whiteColor),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        musicPlayerProvider.artistImages[index].toString()),
                    radius: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    musicPlayerProvider.artistNames[index].toString(),
                    style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
