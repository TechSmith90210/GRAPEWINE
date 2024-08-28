import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/Screens/the_music_pages.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/navigator_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';

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
    onTap: () async {
      provider.setSongName(provider.searchTrackNames[index]);
      provider.setSongArtist(provider.searchTrackArtists[index]);
      // provider.setSongAlbumName(provider.selectedSongAlbum[index]);
      // print('${provider.selectedSongName} ${provider.selectedSongArtist} song');
      provider.setSongDetails(
          '${provider.selectedSongName} ${provider.selectedSongArtist} song audio');
      print(provider.selectedSongDetails);
      // print(provider.selectedSongAlbum);
      String songCover = imageUrl;
      if (songCover.isNotEmpty) {
        songCover = imageUrl;
      } else {
        songCover = 'https://assets.audiomack.com/default-song-image.png';
      }
      provider.setSongImage(songCover);

      var playerProvider =
          Provider.of<NavigatorProvider>(context, listen: false);
      //navigate to the musicpages and expand the miniplayer with the song details and wait for 3 seconds and then start playing the song
      // Navigator.pop(context);
      var musicPlayerProvider =
          Provider.of<MusicPlayerProvider>(context, listen: false);
      if (!playerProvider.isExpanded) {
        playerProvider.setExpanded();
      }
      if (musicPlayerProvider.isInitialized) {
        if (musicPlayerProvider.player.isPlaying.value == true &&
            musicPlayerProvider.player != null) {
          musicPlayerProvider.player.stop();
          musicPlayerProvider
              .fetchSong(provider.selectedSongName, provider)
              .then((value) => musicPlayerProvider.updateDuration(value));
        } else if (!musicPlayerProvider.player.isPlaying.value == true &&
            musicPlayerProvider.player != null) {
          await musicPlayerProvider
              .fetchSong(provider.selectedSongName, provider)
              .then((value) => musicPlayerProvider.updateDuration(value));
          musicPlayerProvider.player.play();
          musicPlayerProvider.playSong();
        }
      }

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
                : NetworkImage(
                        'https://assets.audiomack.com/default-song-image.png')
                    as ImageProvider<Object>,
            fit: BoxFit.cover),
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
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
