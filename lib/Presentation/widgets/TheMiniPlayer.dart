import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/song_player3_screen.dart';
import 'package:grapewine_music_app/Providers/musicPlayer_provider.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';

class TheMiniPlayerWidget extends StatefulWidget {
  const TheMiniPlayerWidget({super.key});

  @override
  _TheMiniPlayerWidgetState createState() => _TheMiniPlayerWidgetState();
}

class _TheMiniPlayerWidgetState extends State<TheMiniPlayerWidget> {
  final DraggableScrollableController _draggableController =
      DraggableScrollableController();

  @override
  void dispose() {
    _draggableController.dispose();
    super.dispose();
  }

  void _toggleSheet() {
    if (_draggableController.size == 0.1) {
      _draggableController.animateTo(
        1.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _draggableController.animateTo(
        0.1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableController,
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) {
            bool isExpanded = constraints.maxHeight >
                MediaQuery.of(context).size.height * 0.2;

            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Minimized player view
                  if (!isExpanded)
                    GestureDetector(
                      onTap: _toggleSheet,
                      child: _buildMinimizedPlayer(context),
                    ),
                  // Expanded player content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          _buildExpandedPlayerContent(),
                          // Add more widgets here if needed
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMinimizedPlayer(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    var musicProvider = Provider.of<MusicPlayerProvider>(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              provider.selectedSongImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      title: Text(
        provider.selectedSongName,
        style: GoogleFonts.redHatDisplay(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        provider.selectedSongArtist,
        style: GoogleFonts.redHatDisplay(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          // Handle play/pause logic here
        },
        icon: IconButton(
          onPressed: () async {
            musicProvider.togglePlayPause();
            if (musicProvider.player.isPlaying.valueOrNull == true) {
              await musicProvider.player.pause();
            } else {
              await musicProvider.player.play();
            }
            setState(() {});
          },
          icon: Icon(
            musicProvider.player.isPlaying.valueOrNull == true
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            size: 30,
          ),
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _buildExpandedPlayerContent() {
    return SongPlayer3Screen();
  }
}
