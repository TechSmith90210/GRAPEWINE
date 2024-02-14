import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/the_music_pages.dart';
import '../../Colors/colors.dart';
import '../../config/firebase_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> firebaseInit;
  @override
  void initState() {
    firebaseInit = FirebaseInit();
    super.initState();
  }

  Future<void> FirebaseInit() async {
    await WidgetsFlutterBinding.ensureInitialized();
    print('widgets binded');
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print('Firebase Initialized');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print('height: $screenHeight');
    print('Width: $screenWidth');
    return Scaffold(
      body: FutureBuilder(
        future: firebaseInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //display splash
            return Center(
              child: Image.asset('assets/grapewine_logo.png'),
            );
          } else if (snapshot.hasError) {
            // Error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            //Success then direct to the main page or authentication
            print('Loading Completed');
            Future.delayed(
                Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TheMusicPages(),
                    ))
                // Get.toNamed('/themusicpages'),
                );
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/grapewine_logo.png'),
                  // Text(
                  //   'Loading Complete!',
                  //   style: GoogleFonts.redHatDisplay(color: whiteColor),
                  // )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
