import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Colors/colors.dart';
import 'View/splash_screen.dart';

void main() {
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
