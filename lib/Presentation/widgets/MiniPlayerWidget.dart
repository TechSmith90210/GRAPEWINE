import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({super.key});

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 12),
        height: 70,
        decoration: BoxDecoration(
            color: blackColor, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: NetworkImage(
                      //         'https://media.pitchfork.com/photos/6505c8ca90b65beacc778d9d/master/pass/Drake-For-all-the-Dogs.jpg'),
                      //     fit: BoxFit.cover),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(3)),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3.15.20',
                      style: GoogleFonts.redHatDisplay(
                          color: whiteColor, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Childish Gambino',
                      style: GoogleFonts.redHatDisplay(
                          color: greyColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow_rounded,
                  color: whiteColor,
                  size: 45,
                ))
          ],
        ));
  }
}
