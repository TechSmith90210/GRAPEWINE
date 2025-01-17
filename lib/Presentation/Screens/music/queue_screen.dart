import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';
import '../../../Providers/musicPlayer_provider.dart';
import '../../../models/playlist.dart';
import '../../widgets/more_options_sheet.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Queue',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
          color: whiteColor,
        ),
      ),
      body: Consumer2<MusicPlayerProvider, SearchProvider>(
        // Listen to MusicPlayerProvider
        builder: (context, musicProvider, searchProvider, child) {
          final queue =
              musicProvider.queue; // Access the queue from the provider
          final currentPlayingSong = searchProvider.selectedSongName;

          return ListView.builder(
            itemCount: queue.length,
            itemBuilder: (context, index) {
              final song = queue[index];

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
                        song: PlaylistSong(
                          songId: song.songId,
                          songName: song.songName,
                          songArtists: song.artists,
                          songImageUrl: song.imageUrl,
                        ),
                      );
                    },
                  );
                },
                tileColor: blackColor.withOpacity(0.4),
                onTap: () async {
                  // Handle song tap
                  // handlePlaylistTap(context: context, playlist: queue, index: index);
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
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.redHatDisplay(
                    color: currentPlayingSong == song.songName
                        ? redColor
                        : whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  song.artists,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.redHatDisplay(
                    color:darkgreyColor ,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                trailing: currentPlayingSong == song.songName
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: MiniMusicVisualizer(
                          color: purpleColor,
                          width: 3,
                          height: 15,
                          radius: 2,
                          animate: musicProvider.player.isPlaying.value,
                        ),
                      )
                    : Text(
                        '${index + 1}',
                        style: GoogleFonts.redHatDisplay(
                          color: darkgreyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
