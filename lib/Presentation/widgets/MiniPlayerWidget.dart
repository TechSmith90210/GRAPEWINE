import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/song_player_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../Colors/colors.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({Key? key}) : super(key: key);

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  static const double _minPlayerHeight = 70;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Miniplayer(

        minHeight: _minPlayerHeight,
        maxHeight: MediaQuery.of(context).size.height,
        builder: (height, percentage) {
          if (height <= _minPlayerHeight + 50.0) {
            return Container(
              padding: EdgeInsets.only(left: 15, right: 17),
              height: 80,
              decoration: BoxDecoration(
                color: blackColor,
                border: Border(
                  bottom: BorderSide(color: blackColor, width: 0),
                  top: BorderSide(color: blackColor, width: 0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          // color: whiteColor,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://qodeinteractive.com/magazine/wp-content/uploads/2020/06/7-Steve-Lacy.jpg')),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Apollo XXI',
                            style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Steve Lacy',
                            style: GoogleFonts.redHatDisplay(
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: whiteColor,
                      size: 45,
                    ),
                  )
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: Container(
                  color: pinkBubbleColor,
                  child: Center(
                    child: Text(
                      'I have been expanded',
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
