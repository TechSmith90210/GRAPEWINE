// import 'package:flutter/material.dart';
// import 'package:genius_lyrics/genius_lyrics.dart';
// import 'package:grapewine_music_app/CustomStrings.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
//
// class LyricsScreen extends StatefulWidget {
//   final String songName;
//   final String songArtist;
//
//   const LyricsScreen({
//     super.key,
//     required this.songName,
//     required this.songArtist,
//   });
//
//   @override
//   State<LyricsScreen> createState() => _LyricsScreenState();
// }
//
// class _LyricsScreenState extends State<LyricsScreen> {
//   List<String> lyrics = [];
//   final ItemScrollController itemScrollController = ItemScrollController();
//   final ItemPositionsListener itemPositionsListener =
//       ItemPositionsListener.create();
//   bool isLoading = true; // To indicate loading state
//   String? errorMessage; // To handle and display errors
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchLyrics();
//   }
//
//   Future<void> _fetchLyrics() async {
//     Genius genius = Genius(accessToken: CustomStrings.geniusAccessToken);
//     try {
//       // Search for the song using the genius package
//       Song? song = (await genius.searchSong(
//         artist: 'Taylor Swift',
//         title: 'Fortnight',
//       ));
//
//       // Debug: print the song object to check its details
//       if (song != null) {
//         // Check if lyrics are available
//         if (song.lyrics != null && song.lyrics!.isNotEmpty) {
//           // Print lyrics to console
//           print("Lyrics for ${widget.songName} by ${widget.songArtist}:");
//           print(song.lyrics); // Print the entire lyrics
//
//           // Split lyrics into lines and update state for UI display
//           setState(() {
//             lyrics = song.lyrics!.split('\n');
//             isLoading = false;
//           });
//
//           // Also print each line of lyrics individually
//           for (var line in lyrics) {
//             print(line); // Printing each lyric line
//           }
//         } else {
//           throw Exception('Lyrics not available for this song.');
//         }
//       } else {
//         throw Exception('Song not found.');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = e.toString();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.songName),
//         automaticallyImplyLeading: true,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(
//                   child: Text(
//                     errorMessage!,
//                     style: const TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   ),
//                 )
//               : SafeArea(
//                   bottom: false,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: ScrollablePositionedList.builder(
//                       itemCount: lyrics.length,
//                       itemBuilder: (context, index) => Padding(
//                         padding: const EdgeInsets.only(bottom: 16.0),
//                         child: Text(
//                           lyrics[index],
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                       itemScrollController: itemScrollController,
//                       itemPositionsListener: itemPositionsListener,
//                     ),
//                   ),
//                 ),
//     );
//   }
// }
