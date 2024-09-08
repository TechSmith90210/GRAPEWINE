import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/widgets/MiniPlayerWidget.dart';
import 'package:provider/provider.dart';

import '../../Providers/like_provider.dart'; // Adjust the path as needed
import '../../Providers/musicPlayer_provider.dart';
import '../../Providers/navigator_provider.dart';
import '../../Providers/search_provider.dart';
import '../../Colors/colors.dart';
import '../../models/song_model.dart';
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
      appBar: AppBarWidget(
          title: 'LIKED SONGS',
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: likedProvider.likedSongs.length,
              itemBuilder: (context, index) {
                final song = likedProvider.likedSongs[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    tileColor: blackColor.withOpacity(0.2),
                    onTap: () async {
                      handleSongTap(
                        context: context,
                        song: Song(
                          imageUrl: song.imageUrl,
                          songName: song.songName,
                          artists: song.artists,
                        ),
                      );
                    },
                    leading: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            song.imageUrl.isNotEmpty
                                ? song.imageUrl
                                : 'https://assets.audiomack.com/default-song-image.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    title: Text(
                      song.songName,
                      style: GoogleFonts.redHatDisplay(
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      softWrap: false,
                      truncateText(song.artists, 23),
                      style: GoogleFonts.redHatDisplay(
                        color: darkgreyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 120, // Adjust width as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            song.duration != null
                                ? '${song.duration!.inMinutes}:${(song.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
                                : '0:00',
                            style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle more actions here
                            },
                            icon: const Icon(Icons.more_horiz),
                            color: whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void handleSongTap({
  required BuildContext context,
  required Song song,
}) async {
  var searchProvider = Provider.of<SearchProvider>(context, listen: false);
  var navigatorProvider =
      Provider.of<NavigatorProvider>(context, listen: false);
  var musicPlayerProvider =
      Provider.of<MusicPlayerProvider>(context, listen: false);

  searchProvider.setSongName(song.songName);
  searchProvider.setSongArtist(song.artists);
  searchProvider.setSongDetails(
      '${searchProvider.selectedSongName} ${searchProvider.selectedSongArtist} song audio');
  print(searchProvider.selectedSongDetails);

  // Set the song cover image with default if necessary
  String songCover = song.imageUrl.isNotEmpty
      ? song.imageUrl
      : 'https://assets.audiomack.com/default-song-image.png';
  searchProvider.setSongImage(songCover);


    if (musicPlayerProvider.player.isPlaying.value) {
      await musicPlayerProvider.player.stop();
      await musicPlayerProvider
          .fetchSong(searchProvider.selectedSongName, searchProvider)
          .then((value) => musicPlayerProvider.updateDuration(value));

    } else {
      await musicPlayerProvider
          .fetchSong(searchProvider.selectedSongName, searchProvider)
          .then((value) => musicPlayerProvider.updateDuration(value));
      await musicPlayerProvider.player.play();
  }
}
