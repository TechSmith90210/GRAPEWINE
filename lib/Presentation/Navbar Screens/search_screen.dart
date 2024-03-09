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
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Trending Searches',
                  style: GoogleFonts.redHatDisplay(
                      color: greenColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 7.0, // space between each bubble
                  runSpacing: 7.0, //space below bubbles
                  alignment: WrapAlignment.spaceBetween,
                  children: artistNames.map((name) {
                    return TrendingBubbleWidget(
                      artistName: name,
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Genres',
                  style: GoogleFonts.redHatDisplay(
                      color: greenColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: blueBubbleColor,
                          borderRadius: BorderRadius.circular(11)),
                      child: Center(
                        child: Text(
                          'Hip Hop',
                          style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
