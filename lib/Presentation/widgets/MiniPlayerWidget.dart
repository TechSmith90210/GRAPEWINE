// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grapewine_music_app/Presentation/Screens/song_player2_screen.dart';
// import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
// import 'package:grapewine_music_app/Providers/navigator_provider.dart';
// import 'package:grapewine_music_app/Providers/search_provider.dart';
// import 'package:provider/provider.dart';
// import '../../Colors/colors.dart';
// import 'package:miniplayer/miniplayer.dart';
//
String truncateText(String text, int maxLength) {
  if (text.isNotEmpty && text.length > maxLength) {
    return text.substring(0, maxLength) + '...';
  }
  return text;
}
//
// class MiniPlayerWidget extends StatefulWidget {
//   const MiniPlayerWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
// }
//
// class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
//   static const double _minPlayerHeight = 70;
//   final ValueNotifier<double> playerExpandProgress = ValueNotifier(_minPlayerHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     var navigationProvider = Provider.of<NavigatorProvider>(context, listen: true);
//     var searchProvider = Provider.of<SearchProvider>(context);
//     var musicPlayerProvider = Provider.of<MusicPlayerProvider>(context);
//
//     // Provide default values if the data is null
//     String image = searchProvider.selectedSongImage ??
//         'https://thefader-res.cloudinary.com/private_images/w_760,c_limit,f_auto,q_auto:best/unnamed-25_wgts3q/steve-lacy-solo-album-apollo-xxi.jpg';
//     String songName = searchProvider.selectedSongName ?? 'No Song Playing';
//     String songArtist = searchProvider.selectedSongArtist ?? 'Unknown Artist';
//
//     MiniplayerController miniplayerController = Provider.of<MiniplayerController>(context);
//
//     return GestureDetector(
//       onTap: () {
//         if (musicPlayerProvider.player.isPlaying.hasValue &&
//             musicPlayerProvider.player.isPlaying.value == true) {
//           if (navigationProvider.isExpanded) {
//             miniplayerController.animateToHeight(state: PanelState.MIN);
//           } else {
//             miniplayerController.animateToHeight(state: PanelState.MAX);
//           }
//           navigationProvider.setExpanded();
//         } else {
//           // Show a loading indicator or a message
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Please wait while the song is loading...'),
//               duration: Duration(seconds: 2),
//             ),
//           );
//         }
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Miniplayer(
//           curve: Curves.linearToEaseOut,
//           controller: miniplayerController,
//           valueNotifier: playerExpandProgress,
//           minHeight: _minPlayerHeight,
//           maxHeight: MediaQuery.of(context).size.height,
//           builder: (height, percentage) {
//             if (height <= _minPlayerHeight + 50.0) {
//               return _buildCollapsedWidget(image, songArtist, songName);
//             }
//             if (navigationProvider.isExpanded) {
//               return const SongPlayer2Screen();
//             } else {
//               return Center(
//                 child: Text(
//                   'No Song Selected',
//                   style: TextStyle(color: whiteColor),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCollapsedWidget(String image, String songArtist, String songName) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 17),
//       height: 80,
//       decoration: BoxDecoration(
//         color: blackColor,
//         border: Border(
//           bottom: BorderSide(color: blackColor, width: 0),
//           top: BorderSide(color: blackColor, width: 0),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                 height: 50,
//                 width: 50,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(image),
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     truncateText(songName, 25),
//                     style: GoogleFonts.redHatDisplay(
//                       color: whiteColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     truncateText(songArtist, 30),
//                     style: GoogleFonts.redHatDisplay(
//                       color: greyColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Consumer<MusicPlayerProvider>(
//             builder: (context, provider, child) {
//               return IconButton(
//                 onPressed: () async {
//                   if (provider.player.isPlaying.valueOrNull == true) {
//                     await provider.player.pause();
//                   } else {
//                     await provider.player.play();
//                   }
//                   setState(() {}); // Update UI based on the new state
//                 },
//                 icon: Icon(
//                   provider.player.isPlaying.valueOrNull == true
//                       ? Icons.pause_rounded
//                       : Icons.play_arrow_rounded,
//                   color: whiteColor,
//                   size: 35,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
