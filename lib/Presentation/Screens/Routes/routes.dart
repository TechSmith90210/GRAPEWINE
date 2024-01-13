import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Presentation/Screens/home_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/login_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/signup_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/splash_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => SplashScreen(),
  '/welcome': (context) => WelcomeScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/home': (context) => HomeScreen(),
};
