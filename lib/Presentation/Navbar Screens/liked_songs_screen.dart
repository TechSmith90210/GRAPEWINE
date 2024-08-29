import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Providers/like_provider.dart'; // Adjust the path as needed
import '../../Providers/musicPlayer_provider.dart';
import '../../Providers/navigator_provider.dart';
import '../../Providers/search_provider.dart';
import '../../Colors/colors.dart';
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
      appBar: AppBarWidget(title: 'LIKED SONGS'),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text(
            '${likedProvider.likedSongs.length}', // Display the number of liked songs
            style: GoogleFonts.redHatDisplay(
              color: whiteColor,
              fontSize: 50,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Songs',
            style: GoogleFonts.redHatDisplay(
              color: whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: likedProvider.likedSongs.length,
              itemBuilder: (context, index) {
                final song = likedProvider.likedSongs[index];

                return ListTile(
                  onTap: () async {
                    var searchProvider =
                        Provider.of<SearchProvider>(context, listen: false);
                    var navigatorProvider =
                        Provider.of<NavigatorProvider>(context, listen: false);
                    var musicPlayerProvider = Provider.of<MusicPlayerProvider>(
                        context,
                        listen: false);

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

                    if (!navigatorProvider.isExpanded) {
                      navigatorProvider.setExpanded();
                    }

                    if (musicPlayerProvider.isInitialized) {
                      if (musicPlayerProvider.player.isPlaying.value) {
                        await musicPlayerProvider.player.stop();
                        await musicPlayerProvider
                            .fetchSong(
                                searchProvider.selectedSongName, searchProvider)
                            .then((value) =>
                                musicPlayerProvider.updateDuration(value));
                      } else {
                        await musicPlayerProvider
                            .fetchSong(
                                searchProvider.selectedSongName, searchProvider)
                            .then((value) =>
                                musicPlayerProvider.updateDuration(value));
                        musicPlayerProvider.player.play();
                        musicPlayerProvider.playSong();
                      }
                    }
                  },
                  leading: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(song.imageUrl.isNotEmpty
                            ? song.imageUrl
                            : 'https://assets.audiomack.com/default-song-image.png'), // Use the image from the song or default
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  title: Text(
                    song.songName, // Display the song name
                    style: GoogleFonts.redHatDisplay(
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    song.artists, // Display the artist name
                    style: GoogleFonts.redHatDisplay(
                      color: darkgreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      likedProvider.toggleLike(song); // Toggle the like status
                    },
                    child: Icon(
                      likedProvider.isLiked(song)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: purpleColor,
                      size: 35,
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
