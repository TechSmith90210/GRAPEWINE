import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../../Colors/colors.dart';
import '../../models/song_model.dart';
import '../Navbar Screens/liked_songs_screen.dart';

class Trendingitemwidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final VoidCallback onTap;

  const Trendingitemwidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Bounceable(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 190,
              width: 140,
              child: Stack(
                children: [
                  Container(
                    height: 185,
                    width: 140,
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: greyishColor,
                      ),
                      child: Icon(
                        Icons.play_arrow_outlined,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              title,
              style: GoogleFonts.redHatDisplay(
                color: whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Text(
              artist,
              style: GoogleFonts.redHatDisplay(
                color: greyColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingSongsScrollableList extends StatefulWidget {
  const TrendingSongsScrollableList({super.key});

  @override
  State<TrendingSongsScrollableList> createState() =>
      _TrendingSongsScrollableListState();
}

class _TrendingSongsScrollableListState
    extends State<TrendingSongsScrollableList> {
  List<String> artistImages = [
    'https://i.pinimg.com/736x/39/24/3f/39243f934b6e1cf7039ca1232f561f98.jpg',
    'https://i.scdn.co/image/ab67616d0000b273bc2fbaa359030887a9a60d7e',
    'https://i.scdn.co/image/ab677762000056b8230d7f6f307880aa1bd08415',
  ];

  List<String> artistSongNames = [
    'CHIHIRO',
    'Fighting Demons',
    '360',
  ];

  List<String> artistNames = [
    'Billie Eilish',
    'Ken Carson',
    'Charli XCX',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Trendingitemwidget(
            imageUrl: artistImages[index],
            title: artistSongNames[index],
            artist: artistNames[index],
            onTap: () {
              Song song = Song(
                  imageUrl: artistImages[index],
                  songName: artistSongNames[index],
                  artists: artistNames[index]);
          },
          );
        },
      ),
    );
  }
}
