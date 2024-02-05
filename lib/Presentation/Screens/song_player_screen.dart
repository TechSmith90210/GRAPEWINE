import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/widgets/ArtistChipsWidget.dart';
import 'package:interactive_slider/interactive_slider.dart';

import '../../Colors/colors.dart';

class SongPlayerScreen extends StatefulWidget {
  const SongPlayerScreen({super.key});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    double _value = 2.0;
    List<String> aritstNames = [
      'Kid Cudi',
      'Pharrell Williams',
      'Travis Scott'
    ];
    List<String> aritstImages = [
      // Cudi
      'https://i.scdn.co/image/ab6761610000e5eb876faa285687786c3d314ae0',
      //pharell
      'https://i.scdn.co/image/ab6761610000e5ebf0789cd783c20985ec3deb4e',
      //travis
      'https://i.scdn.co/image/ab6761610000e5eb19c2790744c792d05570bb71',
    ];
    return Scaffold(
      backgroundColor: darkblueBubbleColor,
      body: Container(
        // margin: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Now Playing',
                  style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'At The Party',
                  style: GoogleFonts.redHatDisplay(
                      color: yellowColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 60,
                  color: darkgreyColor,
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://www.universalmusic.ca/wp-content/uploads/2023/11/AtTheParty-Single-Artwork_FINAL-scaled.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(11)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.textsms_outlined,
                      color: whiteColor,
                      size: 30,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      children: [
                        Text(
                          'At The Party',
                          style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Kid Cudi, Pharell Williams, Travis Scott',
                          style: GoogleFonts.redHatDisplay(
                              color: darkgreyColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Icon(
                      Icons.favorite_border_rounded,
                      color: whiteColor,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 330,
                  child: ProgressBar(
                    progress: Duration(seconds: 30),
                    total: Duration(minutes: 3, seconds: 58),
                    buffered: Duration(minutes: 1, seconds: 30),
                    progressBarColor: whiteColor,
                    thumbColor: whiteColor,
                    baseBarColor: backgroundColor,
                    bufferedBarColor: greyColor,
                    thumbGlowColor: purpleColor,
                    thumbGlowRadius: 0,
                    timeLabelPadding: 5,
                    timeLabelTextStyle: GoogleFonts.redHatDisplay(
                      color: greyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.fast_rewind_rounded,
                      color: whiteColor,
                      size: 60,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.play_arrow_rounded,
                      color: whiteColor,
                      size: 90,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.fast_forward_rounded,
                      color: whiteColor,
                      size: 60,
                    ),
                  ],
                ),
                Container(
                  width: 330,
                  child: InteractiveSlider(
                    startIcon: const Icon(Icons.volume_down),
                    endIcon: const Icon(Icons.volume_up),
                    brightness: Brightness.light,
                    initialProgress: 0.0,
                    iconSize: 30,
                    unfocusedHeight: 20,
                    focusedHeight: 30,
                    min: 1.0,
                    max: 15.0,
                    onChanged: (value) => setState(() => _value = value),
                  ),
                ),
                // Container(
                //   height: 40,
                //   width: 370,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 4,
                //     itemBuilder: (context, index) {
                //       return ArtistChipsWidget();
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 370,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: aritstImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 2),
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: ShapeDecoration(
                            shape: StadiumBorder(
                              side: BorderSide(width: 0.1, color: whiteColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    aritstImages[index].toString()),
                                radius: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                aritstNames[index].toString(),
                                style: GoogleFonts.redHatDisplay(
                                  color: whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
