import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/home/the_music_pages.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../../models/playlist_model.dart';
import '../../models/song_model.dart';
import '../Screens/music/library/liked_songs_screen.dart';
import 'more_options_sheet.dart';

Widget ArtistWidget(BuildContext context, int index) {
  var provider = Provider.of<SearchProvider>(context);
  var imageUrl = provider.searchArtistImages[index].toString();
  return ListTile(
    title: Text(
      provider.searchArtistNames[index],
      style: GoogleFonts.redHatDisplay(
          color: whiteColor, fontWeight: FontWeight.w500),
    ),
    subtitle: Text(
      'Artist',
      style: GoogleFonts.redHatDisplay(
          color: greyColor, fontWeight: FontWeight.w500),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
                : const AssetImage('assets/icons8-user-96.png'),
            fit: BoxFit.cover),
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
  );
}

Widget TrackWidget(BuildContext context, int index) {
  String formattedText(String text) {
    int commaIndex = text.indexOf(',');

    if (commaIndex != -1) {
      return text.substring(1, commaIndex).trim();
    } else {
      return text;
    }
  }

  var provider = Provider.of<SearchProvider>(context);
  var imageUrl = provider.searchTrackImages[index].toString();
  return ListTile(
    onLongPress: () {
      showModalBottomSheet(
        useSafeArea: true,
        enableDrag: true,
        showDragHandle: true,
        backgroundColor: eerieblackColor,
        context: context,
        builder: (context) {
          return MoreOptionsSheet(
              song: PlaylistSongModel(
                  songName: provider.searchTrackNames[index],
                  songArtists: provider.searchTrackArtists[index],
                  songImageUrl: imageUrl));
        },
      );
    },
    onTap: () async {
      handleSongTap(
          context: context,
          song: Song(
              imageUrl: imageUrl,
              songName: provider.searchTrackNames[index],
              artists: provider.searchTrackArtists[index]));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TheMusicPages(),
          ));
    },
    title: Text(
      provider.searchTrackNames[index],
      style: GoogleFonts.redHatDisplay(
          color: whiteColor, fontWeight: FontWeight.w500),
    ),
    subtitle: Text(
      'Track • ${formattedText(provider.searchTrackArtists[index])}',
      style: GoogleFonts.redHatDisplay(
          color: greyColor, fontWeight: FontWeight.w500),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
                : const NetworkImage(
                        'https://assets.audiomack.com/default-song-image.png')
                    as ImageProvider<Object>,
            fit: BoxFit.cover),
      ),
    ),
    trailing: IconButton(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            enableDrag: true,
            showDragHandle: true,
            backgroundColor: eerieblackColor,
            context: context,
            builder: (context) {
              return MoreOptionsSheet(
                  song: PlaylistSongModel(
                      songName: provider.searchTrackNames[index],
                      songArtists: provider.searchTrackArtists[index],
                      songImageUrl: imageUrl));
            },
          );
        },
        icon: Icon(Icons.more_vert_outlined)),
    // iconColor: greyColor,
    splashColor: blackColor,
    hoverColor: blackColor,
    focusColor: blackColor,
    // dense: true,
  );
}

Widget AlbumWidget(BuildContext context, int index) {
  String formattedText(String text) {
    int commaIndex = text.indexOf(',');

    if (commaIndex != -1) {
      return text.substring(1, commaIndex).trim();
    } else {
      return text;
    }
  }

  var provider = Provider.of<SearchProvider>(context);
  var imageUrl = provider.searchAlbumImages[index].toString();
  return ListTile(
    title: Text(
      provider.searchAlbumNames[index],
      style: GoogleFonts.redHatDisplay(
          color: whiteColor, fontWeight: FontWeight.w500),
    ),
    subtitle: Text(
      'Album • ${formattedText(provider.searchAlbumArtists[index])}',
      style: GoogleFonts.redHatDisplay(
          color: greyColor, fontWeight: FontWeight.w500),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
          image: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
              : const AssetImage('assets/icons8-album-96.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
  );
}

Widget SearchResultsWidget(BuildContext context, int index) {
  // Check if index is within valid range
  if (index < 0 || index > 14) {
    return SizedBox(); // Return an empty widget
  }

  // All tracks, artists, albums widgets
  int internalIndex;

  if (index <= 4) {
    internalIndex = index;
    return TrackWidget(context, internalIndex);
  } else if (index > 4 && index <= 9) {
    internalIndex = index - 5;
    return ArtistWidget(context, internalIndex);
  } else {
    internalIndex = index - 10;
    return AlbumWidget(context, internalIndex);
  }
}
