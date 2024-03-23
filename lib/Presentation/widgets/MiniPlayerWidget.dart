import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/song_player2_screen.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';
import '../../Colors/colors.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({Key? key}) : super(key: key);

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  static double _minPlayerHeight = 70;
  final ValueNotifier<double> playerExpandProgress =
      ValueNotifier(_minPlayerHeight);
  MiniplayerController miniplayerController = MiniplayerController();

  @override
  Widget build(BuildContext context) {
    var navigationProvider =
        Provider.of<NavigatorProvider>(context, listen: true);
    var searchProvider = Provider.of<SearchProvider>(context);
    String? image = searchProvider.selectedSongImage;
    String? songName = searchProvider.selectedSongName;
    String? songArtist = searchProvider.selectedSongArtist;
    return GestureDetector(
      onTap: () {
        if (navigationProvider.isExpanded) {
          miniplayerController.animateToHeight(state: PanelState.MIN);
        } else {
          miniplayerController.animateToHeight(state: PanelState.MAX);
        }
        navigationProvider.setExpanded();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Miniplayer(
          controller: miniplayerController,
          valueNotifier: playerExpandProgress,
          minHeight: _minPlayerHeight,
          maxHeight: MediaQuery.of(context).size.height,
          builder: (height, percentage) {
            if (height <= _minPlayerHeight + 50.0) {
              return _buildCollapsedWidget(
                  searchProvider, image, songArtist, songName);
            }
            if (navigationProvider.isExpanded == true) {
              return SongPlayer2Screen();
            } else {
              return Center(
                child: Text('No Song Selected'),
              );
            }
          },
        ),
      ),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text != null && text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text!;
  }

  Widget _buildCollapsedWidget(SearchProvider searchProvider, String? image,
      String? songArtist, String? songName) {
    return Container(
      padding: EdgeInsets.only(left: 17, right: 17),
      height: 80,
      decoration: BoxDecoration(
        color: blackColor,
        // borderRadius: BorderRadius.circular(5)
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
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      image ??
                          'https://thefader-res.cloudinary.com/private_images/w_760,c_limit,f_auto,q_auto:best/unnamed-25_wgts3q/steve-lacy-solo-album-apollo-xxi.jpg', // Provide default image URL here
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateText(songName ?? 'Apollo XXI', 30),
                    style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Text(
                  //   truncateText(songArtist ?? 'Steve Lacy', 30),
                  //   style: GoogleFonts.redHatDisplay(
                  //     color: greyColor,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
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
}
