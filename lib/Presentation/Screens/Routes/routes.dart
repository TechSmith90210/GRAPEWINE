
import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Presentation/Screens/onboarding/splash_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/home/the_music_pages.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';
import '../music/home/home_screen.dart';
import '../onboarding/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => SplashScreen(),
  '/welcome': (context) => WelcomeScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/home': (context) => HomeScreen(),
  '/themusicpages':(context)=>TheMusicPages()
};
