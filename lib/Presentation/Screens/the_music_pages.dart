import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Navbar Screens/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/Navbar Screens/search_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/library_screen.dart';
import 'package:grapewine_music_app/Presentation/Screens/song_player3_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/BottomNavBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/MiniPlayerWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/TheMiniPlayer.dart';
import 'package:provider/provider.dart';
import '../../Colors/colors.dart';
import '../../Providers/navigator_provider.dart';
import '../Navbar Screens/home_screen.dart';

class TheMusicPages extends StatelessWidget {
  const TheMusicPages({super.key});

  @override
  Widget build(BuildContext context) {
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
          TheMiniPlayerWidget()
        ],
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
