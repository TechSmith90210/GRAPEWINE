import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

class SignupProvider extends ChangeNotifier {
  Future<void> signUpUser(BuildContext context, String name, String email,
      String password, DateTime dateOfBirth, String gender) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (email.isEmpty || password.isEmpty) {
        showErrorDialog(context, 'Please enter both email and password.');
        return;
      }

      if (!email.contains('@')) {
        showErrorDialog(context, 'Please enter a valid email address.');
        return;
      }

      if (password.length < 8) {
        showErrorDialog(
            context, 'Password must be at least 8 characters long.');
        return;
      }
      if (user == null) {
        // User is not authenticated
        showErrorDialog(context, 'User not authenticated');
        return;
      }
      Timestamp dob = Timestamp.fromDate(dateOfBirth);

      if (dob == null) {
        showErrorDialog(context, 'Enter your birth date please');
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

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'name': name,
        'email': email,
        'dateOfBirth': dob,
        'gender': gender,
        'dateCreated': DateTime.now(),
        'userId': user.uid,
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((auth) {
        var currentUser = auth.user;
        print("this is the user $currentUser");
      });

      // Close loading indicator
      Get.back();
      // Navigate to home screen
      Get.toNamed('/home');

      print('Successfully created account');
    } on FirebaseAuthException catch (e) {
      // Close loading indicator in case of an error
      Get.back();
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
            onPressed: () => Get.back(),
            child:
                Text('OK', style: GoogleFonts.redHatDisplay(color: whiteColor)),
          ),
        ],
      ),
    );
  }
}
