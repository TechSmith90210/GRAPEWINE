import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

class SignupProvider extends ChangeNotifier {
  Future<void> signUpUser(BuildContext context, String name, String email,
      String password, DateTime dateOfBirth, String gender) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // User is not authenticated
        showErrorDialog(context, 'User not authenticated');
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
        title: Text('Error'),
        content: Text(message),
        backgroundColor: redColor,
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
