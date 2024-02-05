import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';

class ArtistChipsWidget extends StatefulWidget {
  const ArtistChipsWidget({super.key});

  @override
  State<ArtistChipsWidget> createState() => _ArtistChipsWidgetState();
}

class _ArtistChipsWidgetState extends State<ArtistChipsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Chip(
          shape: StadiumBorder(),
          avatar: CircleAvatar(
            foregroundImage: NetworkImage(
                'https://i.scdn.co/image/ab6761610000e5eb876faa285687786c3d314ae0'),
          ),
          backgroundColor: eerieblackColor,
          label: Text(
            'Kid Cudi',
            style: GoogleFonts.redHatDisplay(
                color: whiteColor, fontWeight: FontWeight.w800),
          )),
    );
  }
}
