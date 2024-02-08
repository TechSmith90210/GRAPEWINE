import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/like_provider.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';
import '../widgets/AppBarWidget.dart';

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    var likedProvider = Provider.of<LikedProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(title: 'LIKED SONGS'),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            '200',
            style: GoogleFonts.redHatDisplay(
              color: whiteColor,
              fontSize: 50,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Songs',
            style: GoogleFonts.redHatDisplay(
              color: whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/en/thumb/5/55/Michael_Jackson_-_Thriller.png/220px-Michael_Jackson_-_Thriller.png'),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    title: Text(
                      'Bad',
                      style: GoogleFonts.redHatDisplay(
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    subtitle: Text(
                      'Michael Jackson',
                      style: GoogleFonts.redHatDisplay(
                          color: darkgreyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        likedProvider.setLike(likedProvider.isLiked);
                      },
                      child: Icon(
                          likedProvider.isLiked ?? false
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: purpleColor,
                          size: 35),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
