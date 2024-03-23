import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Navbar Screens/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/Navbar Screens/search_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/BottomNavBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/MiniPlayerWidget.dart';
import 'package:provider/provider.dart';
import '../../Colors/colors.dart';
import '../../Providers/navigator_provider.dart';
import '../Navbar Screens/home_screen.dart';

class TheMusicPages extends StatelessWidget {
  const TheMusicPages({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: eerieblackColor,
      body: Consumer<NavigatorProvider>(
        builder: (context, navigatorProvider, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: IndexedStack(
                  index: navigatorProvider.selectedIndex,
                  children: [
                    HomeScreen(),
                    SearchScreen(),
                    LikedSongsScreen(),
                  ],
                ),
              ),
              if (navigatorProvider.isExpanded) MiniPlayerWidget(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
