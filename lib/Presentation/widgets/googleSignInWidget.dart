import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:provider/provider.dart';

import '../../Providers/auth_provider.dart';

class GoogleSignInButton extends StatefulWidget {
  final String text;

  GoogleSignInButton({Key? key, required this.text});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    var googleSignInProvider = Provider.of<AuthProvider>(context);

    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          googleSignInProvider.signInWithGoogle(context);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/google_icon.png',
              height: 20,
              width: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.text,
              style: GoogleFonts.redHatDisplay(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: eerieblackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
