import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grapewine_music_app/Presentation/Screens/welcome_screen.dart';

import '../../config/screen_size.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Get.toNamed('/welcome');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print('height: $screenHeight');
    print('Width: $screenWidth');
    return Scaffold(
      body: Center(
        child: Image.asset('assets/grapewine_logo.png'),
      ),
    );
  }
}
