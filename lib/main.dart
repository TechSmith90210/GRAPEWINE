import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Data/services/local_helper.dart';
import 'package:grapewine_music_app/Presentation/Screens/the_music_pages.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:grapewine_music_app/Providers/login_provider.dart';
import 'package:grapewine_music_app/Providers/signup_provider.dart';
import 'package:grapewine_music_app/Providers/google_signin_provider.dart';
import 'package:grapewine_music_app/Providers/gender_provider.dart';
import 'package:grapewine_music_app/Providers/password_provider.dart';
import 'package:grapewine_music_app/Providers/date_provider.dart';
import 'package:grapewine_music_app/Providers/albumInfo_provider.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:grapewine_music_app/Providers/newFinds_provider.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'Colors/colors.dart';
import 'Providers/like_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LocalHelper
  final localHelper = await LocalHelper.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigatorProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => GenderProvider()),
        ChangeNotifierProvider(create: (context) => PasswordProvider()),
        ChangeNotifierProvider(create: (context) => DateProvider(initialDate: DateTime.now())),
        ChangeNotifierProvider(create: (context) => AlbumInfoProvider()),
        ChangeNotifierProvider(create: (context) => LikedProvider()),
        ChangeNotifierProvider(create: (context) => MusicPlayerProvider()),
        ChangeNotifierProvider(create: (context) => NewReleasesProvider()),
        ChangeNotifierProvider(create: (context) => NewFindsProvider()),
        ChangeNotifierProvider(create: (context) => AccessTokenProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => localHelper), // Provide LocalHelper as ChangeNotifier
      ],
      child: const MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'GrapeWine Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorSchemeSeed: whiteColor,
        fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      ),
      home: const TheMusicPages(),
    );
  }
}
