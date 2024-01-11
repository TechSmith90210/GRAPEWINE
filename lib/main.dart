import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/firebase_options.dart';
import 'Colors/colors.dart';
import 'View/splash_screen.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  print('widgets binded');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Firebase Initialized');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrapeWine Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Red Hat Display',
      ),
      home: SplashScreen(),
    );
  }
}
