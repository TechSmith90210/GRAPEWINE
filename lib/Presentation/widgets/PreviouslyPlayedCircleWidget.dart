import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';

class PreviouslyPlayedCircleWidget extends StatefulWidget {
  const PreviouslyPlayedCircleWidget({super.key});

  @override
  State<PreviouslyPlayedCircleWidget> createState() =>
      _PreviouslyPlayedCircleWidgetState();
}

class _PreviouslyPlayedCircleWidgetState
    extends State<PreviouslyPlayedCircleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          // padding:
          //     const EdgeInsets.only(left: 13, right: 15, top: 15, bottom: 25),
          padding:
              const EdgeInsets.only(left: 13, right: 15, top: 10, bottom: 5),
          child: Container(
            height: 60,
            width: 94,
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/albumcov1.jpg'),
                    fit: BoxFit.cover),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: purpleColor,
                    ),
                    borderRadius: BorderRadius.circular(47))),
          ),
        ),
        // SizedBox(height: 10,),
        Text(
          'Diamond Eyes',
          style: GoogleFonts.redHatDisplay(
            fontSize: 16,
            color: redColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'Deftones',
          style: GoogleFonts.redHatDisplay(
            fontSize: 12,
            color: darkgreyColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
