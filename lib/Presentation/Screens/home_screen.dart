import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Home Screen',
            style: GoogleFonts.redHatDisplay(color: whiteColor),
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: Text(
                'Go Back',
                style: GoogleFonts.redHatDisplay(color: whiteColor),
              ))
        ],
      ),
    );
  }
}
