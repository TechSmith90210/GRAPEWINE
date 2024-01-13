import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grapewine_music_app/Presentation/Screens/home_screen.dart';

class GoogleSignInProvider extends ChangeNotifier {
  Future<void> signinwithgoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(authCredential);
        print('Welcome $googleSignInAccount');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        _googleSignIn.signOut();
        print('signed out too');
      }
    } catch (e) {
      print('Error Occured: $e');
    }
    notifyListeners();
  }
}
