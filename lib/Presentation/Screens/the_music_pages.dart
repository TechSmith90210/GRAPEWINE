import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Presentation/Navbar%20Pages/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/Navbar%20Pages/search_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/BottomNavBarWidget.dart';
import 'package:provider/provider.dart';

import '../../Providers/navigator_provider.dart';
import '../Navbar Pages/home_screen.dart';

class TheMusicPages extends StatefulWidget {
  const TheMusicPages({Key? key});

  @override
  State<TheMusicPages> createState() => _TheMusicPagesState();
}

class _TheMusicPagesState extends State<TheMusicPages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, navigatorProvider, child) {
        return Scaffold(
          body: [
            HomeScreen(),
            SearchScreen(),
            LikedSongsScreen(),
          ][navigatorProvider.selectedIndex],
          bottomNavigationBar: BottomNavBarWidget(),
        );
      },
    );
  }
}
