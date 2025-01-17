import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../Colors/colors.dart';
import '../../../../../Providers/musicPlayer_provider.dart';
import '../../../../../Providers/playlist_provider.dart';
import '../../../../../models/playlist.dart';
import '../../../../../models/song_model.dart';
import '../../../models/album_model.dart';
import '../../widgets/more_options_sheet.dart';
import 'add_to_playlist_screen.dart';

class SongListsScreen extends StatelessWidget {
  final AlbumModel album;

  const SongListsScreen({super.key, required this.album});

  List<Song> mapPlaylistSongsToSongs(List<AlbumSong> albumSongs) {
    return albumSongs.map((albumSong) {
      return Song(
        songName: albumSong.name,
        artists: albumSong.artists,
        imageUrl: albumSong.imageUrl,
        songId: albumSong.id,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var musicProvider = Provider.of<MusicPlayerProvider>(context);

    return Scaffold(
      body: Consumer<PlaylistProvider>(
        builder: (context, playlistProvider, child) {
          List<AlbumSong> songs = album.songs;

          final albumSongs = mapPlaylistSongsToSongs(songs);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  album.name,
                  style: GoogleFonts.redHatDisplay(
                      color: redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                foregroundColor: whiteColor,
                actions: [
                  IconButton(
                    onPressed: () async {
                      if (musicProvider.player.isPlaying.value) {
                        await musicProvider.player.pause();
                      }
                      // Handle playlist play
                      musicProvider.handlePlaylistTap(
                          context: context, playlist: albumSongs);
                    },
                    icon: Icon(
                      musicProvider.player.isPlaying.value
                          ? Icons.pause_outlined
                          : Icons.play_arrow_outlined,
                      size: 20,
                    ),
                    color: whiteColor,
                  ),
                ],
                expandedHeight: 300.0,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: album.imageUrl != null &&
                                    album.imageUrl!.isNotEmpty
                                ? NetworkImage(album.imageUrl!)
                                : const NetworkImage(
                                    'https://assets.audiomack.com/default-song-image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      album.name,
                                      style: GoogleFonts.redHatDisplay(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${album.songs.length} songs',
                                      style: GoogleFonts.redHatDisplay(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: redColor,
                                  minimumSize: const Size(50, 50),
                                ),
                                onPressed: () async {
                                  if (musicProvider.player.isPlaying.value) {
                                    await musicProvider.player.pause();
                                  }

                                  // Handle playlist play
                                  musicProvider.handlePlaylistTap(
                                      context: context, playlist: albumSongs);
                                },
                                icon: Icon(
                                  musicProvider.player.isPlaying.value
                                      ? Icons.pause_outlined
                                      : Icons.play_arrow_outlined,
                                  size: 30,
                                ),
                                color: whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = songs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Slidable(
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              autoClose: true,
                              onPressed: (context) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddToPlaylistScreen(
                                          playlistSongModel: PlaylistSong(
                                              songName: song.name,
                                              songArtists: song.artists,
                                              songImageUrl: song.imageUrl)),
                                    ));
                              },
                              backgroundColor: redColor,
                              foregroundColor: Colors.white,
                              icon: Icons.playlist_add,
                              label: 'Remove',
                            ),
                          ],
                        ),
                        child: ListTile(
                          tileColor: blackColor.withOpacity(0.2),
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
                                        songId: song.id,
                                        songName: song.name,
                                        songArtists: song.artists,
                                        songImageUrl: song.imageUrl));
                              },
                            );
                          },
                          onTap: () {
                            musicProvider.handlePlaylistTap(
                              context: context,
                              playlist: mapPlaylistSongsToSongs(album.songs),
                              index: index,
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
                            song.name,
                            style: GoogleFonts.redHatDisplay(
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            song.artists,
                            style: GoogleFonts.redHatDisplay(
                              color: darkgreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          trailing: Text(
                            song.trackNumber.toString(),
                            style: GoogleFonts.redHatDisplay(
                              color: darkgreyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: songs.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
