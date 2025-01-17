import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Data/services/local_helper.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/home/the_music_pages.dart';
import 'package:grapewine_music_app/Providers/album_provider.dart';
import 'package:grapewine_music_app/Providers/auth_provider.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:grapewine_music_app/Providers/playlist_provider.dart';
import 'package:grapewine_music_app/Providers/recently_played_provider.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'Colors/colors.dart';
import 'Providers/like_provider.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'refreshAccessToken') {
      print('Background task started: Refreshing access token...');
      try {
        final AccessTokenProvider tokenProvider = AccessTokenProvider();
        await tokenProvider.getAccessToken();
        print('Access token updated successfully in the background.');
      } catch (e) {
        print('Error while refreshing access token: $e');
      }
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher,
      isInDebugMode: false); // Set `isInDebugMode: false` for production
  Workmanager().registerPeriodicTask(
    '1', // Unique identifier for the task
    'refreshAccessToken', // Task name
    frequency: const Duration(minutes: 15),
  );
  final localHelper = LocalHelper();
  await localHelper.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigatorProvider()),
        ChangeNotifierProvider(
            create: (context) => AuthProvider(initialDate: DateTime.now())),
        ChangeNotifierProvider(create: (context) => MusicPlayerProvider()),
        ChangeNotifierProvider(create: (context) => NewReleasesProvider()),
        ChangeNotifierProvider(create: (context) => AccessTokenProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => AlbumProvider(),),
        ChangeNotifierProvider(
          create: (context) {
            final likedProvider = LikedProvider();
            likedProvider.loadFromIsar(localHelper);
            return likedProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            final recentlyPlayedProvider = RecentlyPlayedProvider();
            recentlyPlayedProvider.loadFromIsar(localHelper);
            return recentlyPlayedProvider;
          },
        ),
        ChangeNotifierProvider.value(value: localHelper),
        ChangeNotifierProvider(
          create: (context) {
            final playlistProvider = PlaylistProvider();
            playlistProvider.loadPlaylists(localHelper);
            return playlistProvider;
          },
        ),
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      title: 'GrapeWine Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        colorSchemeSeed: whiteColor,
        fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      ),
      home: const TheMusicPages(),
    );
  }
}
