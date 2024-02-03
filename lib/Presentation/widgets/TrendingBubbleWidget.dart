import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Colors/colors.dart';

class TrendingBubbleWidget extends StatelessWidget {
  final String artistName;

  TrendingBubbleWidget({required this.artistName});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      purpleBubbleColor,
      blueBubbleColor,
      darkblueBubbleColor,
      lightpurpleBubbleColor,
      pinkBubbleColor,
      greenColor
    ];

    final Random random = Random();
    final Color color = colors[random.nextInt(colors.length)];

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(37),
      ),
      child: Text(
        artistName,
        style: GoogleFonts.redHatDisplay(
            color: whiteColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
