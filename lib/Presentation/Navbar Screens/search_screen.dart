import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchSongWidget.dart';
import '../../Colors/colors.dart';

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
        appBar: AppBarWidget(
          title: 'SEARCH',
          leading: ImageIcon(
            const AssetImage("assets/grapewine logo medium.png"),
            color: purpleColor,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: CircleAvatar(
                backgroundColor: Color(0xffE6E6E6),
                backgroundImage: NetworkImage('https://i.pinimg.com/736x/3c/fe/f0/3cfef07dbfaea9c6229ec5eb4aa305e0.jpg'),
                // child: Icon(
                //   Icons.person,
                //   color: Color(0xffCCCCCC),
                // ),
              ),
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: const SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SearchBarWidget(),
              ],
            ),
          ),
        ));
  }
}
