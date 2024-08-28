import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/newFinds_provider.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';

class NewFindsWidget extends StatefulWidget {
  int index;
  NewFindsWidget({super.key, required this.index});

  @override
  State<NewFindsWidget> createState() => _NewFindsWidgetState();
}

class _NewFindsWidgetState extends State<NewFindsWidget>
    with AutomaticKeepAliveClientMixin<NewFindsWidget> {
  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var provider = Provider.of<NewFindsProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 5, top: 10, bottom: 5),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        provider.albumCovers[widget.index].toString()),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(11),
                border: Border(
                    bottom: BorderSide(
                        width: 50, color: blackColor.withOpacity(0.6)))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  truncateText(
                      provider.albumNames[widget.index].toString(), 15),
                  style: GoogleFonts.redHatDisplay(
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  truncateText(
                      provider.albumArtists[widget.index].toString(), 15),
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

  @override
  bool get wantKeepAlive => true;
}
