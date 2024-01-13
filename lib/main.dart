import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grapewine_music_app/Providers/date_provider.dart';
import 'package:grapewine_music_app/Providers/gender_provider.dart';
import 'package:grapewine_music_app/Providers/google_signin_provider.dart';
import 'package:grapewine_music_app/Providers/login_provider.dart';
import 'package:grapewine_music_app/Providers/signup_provider.dart';
import 'package:grapewine_music_app/config/firebase_options.dart';
import 'package:provider/provider.dart';
import 'Colors/colors.dart';
import 'Presentation/Screens/splash_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => GenderProvider()),
        ChangeNotifierProvider(
            create: (context) => DateProvider(initialDate: DateTime.now())),
      ],
      child: MaterialApp(
        title: 'GrapeWine Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: 'Red Hat Display',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
