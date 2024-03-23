import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';
import '../../Providers/search_provider.dart';
import 'the_music_pages.dart';

class SongPlayer2Screen extends StatefulWidget {
  const SongPlayer2Screen({super.key});

  @override
  State<SongPlayer2Screen> createState() => _SongPlayer2ScreenState();
}

class _SongPlayer2ScreenState extends State<SongPlayer2Screen> {
  Duration? duration;
  @override
  Future<void> _initializeState() async {
    super.initState();
    Future.delayed(Duration.zero, () {
      var provider = Provider.of<SearchProvider>(context, listen: false);
      var musicPlayerProvider =
          Provider.of<MusicPlayerProvider>(context, listen: false);

      var songName = provider.selectedSongDetails;

      musicPlayerProvider.fetchSong(songName, context).then((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });
    });
  }
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MusicPlayerProvider>(context);
    if (provider.isPlayed) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: eerieblackColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TheMusicPages(),
                      ));
                },
                icon: Icon(Icons.keyboard_arrow_down_sharp,
                    size: 55, color: redColor)),
            Center(
              child: Text(
                'Song Playing',
                style: GoogleFonts.redHatDisplay(color: whiteColor),
              ),
            )
          ],
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: eerieblackColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No Song Selected',
              style: GoogleFonts.redHatDisplay(color: whiteColor),
            ),
          )
        ],
      ),
    );
  }
}
