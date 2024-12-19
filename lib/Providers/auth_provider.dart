import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Presentation/Screens/music/home/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  final DateTime initialDate; // Store the initial date

  // Add initialDate parameter in the constructor
  AuthProvider({required this.initialDate});
  // Google SignIn method
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(authCredential);
        print('Welcome ${googleSignInAccount.displayName}');

        // Navigate to home screen after successful sign-in
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

        // Sign out from Google
        _googleSignIn.signOut();
        print('Signed out too');
      }
    } catch (e) {
      print('Error Occurred: $e');
    }
    notifyListeners();
  }

  // Gender selection logic
  String _selectedGender = 'Gender';
  var _genders = ['Gender', 'Male', 'Female'];

  String get selectedGender => _selectedGender;
  List<String> get genders => _genders;

  void setGender(String newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }

  // Date selection logic
  DateTime? _selectedDate = DateTime.now();

  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime? newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  // Login method with email and password
  Future<void> login(BuildContext context, String email, String password) async {
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
      final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user;

      if (firebaseUser != null) {
        Get.toNamed('/home');
        print('Login Success');
      } else {
        Fluttertoast.showToast(msg: 'Authentication failed', toastLength: Toast.LENGTH_SHORT);
        print('Authentication failed');
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      showErrorDialog(context, e.message.toString());
    }
  }

  // Error dialog for displaying error messages
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

  // Sign up method
  Future<void> signUpUser(BuildContext context, String name, String email, String password, DateTime dateOfBirth, String gender) async {
    try {
      // Validations
      if (name.isEmpty) {
        showErrorDialog(context, 'Please enter your name');
        return;
      }
      if (email.isEmpty || password.isEmpty) {
        showErrorDialog(context, 'Please enter email and password');
        return;
      }
      if (!email.contains('@')) {
        showErrorDialog(context, 'Please enter a valid email address');
        return;
      }

      // Create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((auth) {
        var currentUser = auth.user;
        print("Current User: $currentUser");
      });

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not authenticated');
        return;
      }

      // Show loading indicator
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      // Store user data in Firestore
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

      // Navigate to home screen after successful sign-up
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      print('Successfully created account');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading indicator
      print('Error: $e');
      showErrorDialog(context, e.message.toString());
    }
    notifyListeners();
  }

  // Password visibility toggle
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
