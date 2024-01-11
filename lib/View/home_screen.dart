import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Screen',
          style: GoogleFonts.redHatDisplay(color: whiteColor),
        ),
      ),
    );
  }
}
