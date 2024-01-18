import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';
import '../widgets/AppBarWidget.dart';

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'LIKED SONGS'),
      body: Center(
        child: Text(
          'Liked Songs Page',
          style: GoogleFonts.redHatDisplay(color: whiteColor),
        ),
      ),
    );
  }
}
