import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:provider/provider.dart';

class NewReleasesWidget extends StatefulWidget {
  int index;
  NewReleasesWidget({super.key, required this.index});

  @override
  State<NewReleasesWidget> createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewReleasesProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 5, top: 10, bottom: 5),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 320,
            height: 175,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        provider.albumCovers[widget.index].toString()),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(11),
                border: Border(
                    bottom: BorderSide(
                        width: 50, color: blackColor.withOpacity(0.6)))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  provider.albumNames[widget.index].toString(),
                  style: GoogleFonts.redHatDisplay(
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  provider.albumArtists[widget.index].toString(),
                  style: GoogleFonts.redHatDisplay(
                    color: greyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
