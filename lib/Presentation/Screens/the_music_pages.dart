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
  const TheMusicPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, navigatorProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: const [
                  HomeScreen(),
                  SearchScreen(),
                  LikedSongsScreen(),
                ][navigatorProvider.selectedIndex],
              ),
              const MiniPlayerWidget()
            ],
          ),
          bottomNavigationBar: const BottomNavBarWidget(),
        );
      },
    );
  }
}
