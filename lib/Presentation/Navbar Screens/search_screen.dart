import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchSongWidget.dart';
import '../../Colors/colors.dart';
import '../widgets/TrendingBubbleWidget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> artistNames = [
      'Ed Sheeran',
      'Ariana Grande',
      'Drake',
      'Taylor Swift',
      'The Weeknd',
      'Beyoncé',
      'Kanye West',
      'Dua Lipa',
      'Ice Spice'
    ];

    return Scaffold(
        appBar: AppBarWidget(title: 'SEARCH'),
        body: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SearchBarWidget(),
                // SearchSongWidget(),
              ],
            ),
          ),
        ));
  }
}
