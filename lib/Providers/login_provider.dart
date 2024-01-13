import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grapewine_music_app/Presentation/Screens/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  Future<void> login(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showErrorDialog(context, 'Please enter both email and password.');
      return;
    }

    if (!email.contains('@')) {
      showErrorDialog(context, 'Please enter a valid email address.');
      return;
    }

    if (password.length < 8) {
      showErrorDialog(context, 'Password must be at least 8 characters long.');
      return;
    }

    try {
      final User? firebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (firebaseUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        print('Login Success');
      } else {
        Fluttertoast.showToast(
            msg: 'Authentication failed', toastLength: Toast.LENGTH_SHORT);
        print('Authentication failed');
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      showErrorDialog(
          context, e.message.toString()); // Show specific error message
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
