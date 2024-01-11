import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grapewine_music_app/View/home_screen.dart';

class Auth {
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (!(firebaseUser == null)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        print('Login Success');
      } else {
        Fluttertoast.showToast(
            msg: 'Please enter email and password',
            toastLength: Toast.LENGTH_SHORT);
        print('Please enter email & password');
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }

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
  }
}
