import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Center(
        child: Text(
          'Song Player',
          style: GoogleFonts.redHatDisplay(color: whiteColor),
        ),
      ),
    );
  }
}
