import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/search/search_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/library_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/song_player3_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/BottomNavBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/TheMiniPlayer.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Colors/colors.dart';
import '../../../../Providers/navigator_provider.dart';
import 'home_screen.dart';

class TheMusicPages extends StatelessWidget {
  const TheMusicPages({super.key});

  @override
  Widget build(BuildContext context) {
    var musicProvider = Provider.of<MusicPlayerProvider>(context);
    return Scaffold(
      backgroundColor: eerieblackColor,
      body: Stack(
        children: [
          // Main content with IndexedStack for navigation
          Consumer<NavigatorProvider>(
            builder: (context, navigatorProvider, child) {
              return IndexedStack(
                index: navigatorProvider.selectedIndex,
                children: const [
                  HomeScreen(),
                  SearchScreen(),
                  LibraryScreen(),
                ],
              );
            },
          ),
          // Draggable Scrollable Bottom Sheet for mini player
          if(musicProvider.firstSongRun)
            const TheMiniPlayerWidget()
        ],
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
