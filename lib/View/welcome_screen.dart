import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Reduced Opacity
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9),
              BlendMode.srcATop,
            ),
            child: Image.asset(
              "assets/welcome_back_image.png",
              fit: BoxFit.cover,
            ),
          ),

          // Other widgets can be added on top of the image
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/grapewine_logo.png',
                height: 125,
                width: 125,
              ),
              Text(
                'GRAPEWINE',
                style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w700, color: redColor, fontSize: 25),
              ),
              SizedBox(height: 3),
              Text(
                '"The Best Music Collection"',
                style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    fontSize: 20),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: redColor,
                  ),
                  child: Text(
                    "GET STARTED",
                    style: GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
