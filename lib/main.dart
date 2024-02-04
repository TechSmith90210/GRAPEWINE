import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grapewine_music_app/Presentation/Screens/Routes/routes.dart';
import 'package:grapewine_music_app/Presentation/Screens/demo.dart';
import 'package:grapewine_music_app/Presentation/Screens/song_player_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/the_music_pages.dart';
import 'package:grapewine_music_app/Providers/albumInfo_provider.dart';
import 'package:grapewine_music_app/Providers/date_provider.dart';
import 'package:grapewine_music_app/Providers/gender_provider.dart';
import 'package:grapewine_music_app/Providers/google_signin_provider.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:grapewine_music_app/Providers/login_provider.dart';
import 'package:grapewine_music_app/Providers/password_provider.dart';
import 'package:grapewine_music_app/Providers/signup_provider.dart';
import 'package:grapewine_music_app/config/firebase_options.dart';
import 'package:provider/provider.dart';
import 'Colors/colors.dart';
import 'Providers/navigator_provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigatorProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => GenderProvider()),
        ChangeNotifierProvider(create: (context) => PasswordProvider()),
        ChangeNotifierProvider(
            create: (context) => DateProvider(initialDate: DateTime.now())),
        ChangeNotifierProvider(create: (context) => AlbumInfoProvider()),
        ChangeNotifierProvider(create: (context) => LikedProvider()),
      ],
      child: GetMaterialApp(
        title: 'GrapeWine Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // useMaterial3: true,
          scaffoldBackgroundColor: backgroundColor,
          colorSchemeSeed: whiteColor,
          fontFamily: 'Red Hat Display',
        ),
        // initialRoute: '/splash',
        // routes: routes,
        // home: TheMusicPages(),
        // home: DemoPage(),
      home: SongPlayerScreen(),
      ),
    );
  }
}
