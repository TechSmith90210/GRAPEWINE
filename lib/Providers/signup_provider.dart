import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

import '../Presentation/Navbar Pages/home_screen.dart';

class SignupProvider extends ChangeNotifier {
  Future<void> signUpUser(BuildContext context, String name, String email,
      String password, DateTime dateOfBirth, String gender) async {
    try {
      // validations
      if (name.isEmpty) {
        showErrorDialog(context, 'Please enter your name');
        return;
      }
      if (email.isEmpty || password.isEmpty) {
        showErrorDialog(context, 'Please enter email and password');
        return;
      }
      if (!email.contains('@')) {
        showErrorDialog(context, 'Please enter valid email address');
        return;
      }

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((auth) {
        var currentUser = auth.user;
        print("this is the user $currentUser");
      });
      User? user = FirebaseAuth.instance.currentUser;
      print(user);
      if (user == null) {
        // User is not authenticated
        // You might want to handle this case, perhaps redirecting to a login screen
        print('User not authenticated');
        return;
      }
      // Show loading indicator
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      Timestamp dob = Timestamp.fromDate(dateOfBirth);

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'name': name,
        'email': email,
        'dateOfBirth': dob,
        'gender': gender,
        'dateCreated': DateTime.now(),
        'userId': user.uid,
      });

      // Close loading indicator
      Navigator.pop(context);

      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      print('Successfully created account');
    } on FirebaseAuthException catch (e) {
      // Close loading indicator in case of an error
      Navigator.pop(context);

      // Handle error - you might want to show an error message to the user
      print('Error: $e');
    }
    notifyListeners();
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error',
          style: GoogleFonts.redHatDisplay(color: whiteColor),
        ),
        content: Text(
          message,
          style: GoogleFonts.redHatDisplay(color: whiteColor),
        ),
        backgroundColor: redColor,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.redHatDisplay(color: whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
