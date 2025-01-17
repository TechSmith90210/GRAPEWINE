import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/song_lists_screen.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:grapewine_music_app/models/album_model.dart';
import 'package:provider/provider.dart';
import '../../models/playlist.dart';
import 'more_options_sheet.dart';

// Widget ArtistWidget(BuildContext context, int index) {
//   var provider = Provider.of<SearchProvider>(context);
//   var imageUrl = provider.searchArtistImages[index].toString();
//   return ListTile(
//     title: Text(
//       provider.searchArtistNames[index],
//       style: GoogleFonts.redHatDisplay(
//           color: whiteColor, fontWeight: FontWeight.w500),
//     ),
//     subtitle: Text(
//       'Artist',
//       style: GoogleFonts.redHatDisplay(
//           color: greyColor, fontWeight: FontWeight.w500),
//     ),
//     leading: Container(
//       height: 60,
//       width: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40),
//         image: DecorationImage(
//             image: imageUrl.isNotEmpty
//                 ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
//                 : const AssetImage('assets/icons8-user-96.png'),
//             fit: BoxFit.cover),
//       ),
//     ),
//     trailing: const Icon(Icons.arrow_forward_ios_rounded),
//   );
// }

// Widget TrackWidget(BuildContext context, int index) {
//   String formattedText(String text) {
//     int commaIndex = text.indexOf(',');
//
//     if (commaIndex != -1) {
//       return text.substring(1, commaIndex).trim();
//     } else {
//       return text;
//     }
//   }
//
//   var provider = Provider.of<SearchProvider>(context);
//   var imageUrl = provider.searchAlbumImages[index].toString();
//   return ListTile(
//     onLongPress: () {
//       showModalBottomSheet(
//         useSafeArea: true,
//         enableDrag: true,
//         showDragHandle: true,
//         backgroundColor: eerieblackColor,
//         context: context,
//         builder: (context) {
//           return MoreOptionsSheet(
//               song: PlaylistSong(
//                   songName: provider.searchAlbumNames[index],
//                   songArtists: provider.searchAlbumArtists[index],
//                   songImageUrl: imageUrl));
//         },
//       );
//     },
//     onTap: () async {
//       var musicProvider = Provider.of<MusicPlayerProvider>(context);
//
//       musicProvider.handleSongTap(
//           context: context,
//           song: Song(
//               imageUrl: imageUrl,
//               songName: provider.searchAlbumNames[index],
//               artists: provider.searchAlbumArtists[index]));
//
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TheMusicPages(),
//           ));
//     },
//     title: Text(
//       provider.searchAlbumNames[index],
//       style: GoogleFonts.redHatDisplay(
//           color: whiteColor, fontWeight: FontWeight.w500),
//     ),
//     subtitle: Text(
//       'Track • ${formattedText(provider.searchTrackArtists[index])}',
//       style: GoogleFonts.redHatDisplay(
//           color: greyColor, fontWeight: FontWeight.w500),
//     ),
//     leading: Container(
//       height: 60,
//       width: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(3),
//         image: DecorationImage(
//             image: imageUrl.isNotEmpty
//                 ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
//                 : const NetworkImage(
//                         'https://assets.audiomack.com/default-song-image.png')
//                     as ImageProvider<Object>,
//             fit: BoxFit.cover),
//       ),
//     ),
//     trailing: IconButton(
//         onPressed: () {
//           showModalBottomSheet(
//             useSafeArea: true,
//             enableDrag: true,
//             showDragHandle: true,
//             backgroundColor: eerieblackColor,
//             context: context,
//             builder: (context) {
//               return MoreOptionsSheet(
//                   song: PlaylistSong(
//                       songName: provider.searchAlbumNames[index],
//                       songArtists: provider.searchAlbumArtists[index],
//                       songImageUrl: imageUrl));
//             },
//           );
//         },
//         icon: Icon(Icons.more_vert_outlined)),
//     // iconColor: greyColor,
//     splashColor: blackColor,
//     hoverColor: blackColor,
//     focusColor: blackColor,
//     // dense: true,
//   );
// }

Widget albumWidget(BuildContext context, int index) {
  String formattedText(String text) {
    int commaIndex = text.indexOf(',');

    if (commaIndex != -1) {
      return text.substring(1, commaIndex).trim();
    } else {
      return text;
    }
  }

  var provider = Provider.of<SearchProvider>(context);

  // Get the album model from the provider
  var album = provider.searchAlbums[index];

  var imageUrl = album.imageUrl!.isNotEmpty
      ? album.imageUrl
      : 'assets/icons8-album-96.png';
  var albumName = album.name;
  var albumArtist = album.artist;

  return ListTile(
    onTap: () async {
      // Navigate to SongListScreen and pass the AlbumModel as a parameter
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongListsScreen(
            album: album,
          ), // Pass AlbumModel
        ),
      );
    },
    title: Text(
      albumName,
      style: GoogleFonts.redHatDisplay(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    subtitle: Text(
      '${album.type} • ${formattedText(album.artist)}',
      style: GoogleFonts.redHatDisplay(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
          image: imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl) as ImageProvider<Object>
              : const AssetImage('assets/icons8-album-96.png')
                  as ImageProvider<Object>,
          fit: BoxFit.cover,
        ),
      ),
    ),
    splashColor: Colors.black,
    hoverColor: Colors.black,
    focusColor: Colors.black,
  );
}
