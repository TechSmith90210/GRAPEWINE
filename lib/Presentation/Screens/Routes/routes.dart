import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/playlist/playlists_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/onboarding/splash_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/home/the_music_pages.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';
import '../music/home/home_screen.dart';
import '../onboarding/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => const SplashScreen(),
  '/welcome': (context) => WelcomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignUpScreen(),
  '/home': (context) => const HomeScreen(),
  '/themusicpages': (context) => const TheMusicPages(),
  '/playlists': (context) => const PlaylistsScreen()
};
