import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';

class NewFindsWidget extends StatefulWidget {
  const NewFindsWidget({super.key});

  @override
  State<NewFindsWidget> createState() => _NewFindsWidgetState();
}

class _NewFindsWidgetState extends State<NewFindsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 5, top: 10, bottom: 5),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://i.redd.it/d3oirpfd91171.jpg'),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(11),
                border: Border(
                    bottom: BorderSide(
                        width: 50, color: blackColor.withOpacity(0.6)))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'INFINITY',
                  style: GoogleFonts.redHatDisplay(
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Scarlxrd',
                  style: GoogleFonts.redHatDisplay(
                    color: greyColor,
                    fontWeight: FontWeight.w800,
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
