import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grapewine_music_app/Presentation/Screens/home_screen.dart';


class LoginProvider extends ChangeNotifier {
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
    notifyListeners();
  }
}
