import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/Screens/song_player3_screen.dart';
import '../../Colors/colors.dart';

class TheMiniPlayerWidget extends StatefulWidget {
  const TheMiniPlayerWidget({Key? key}) : super(key: key);

  @override
  _TheMiniPlayerWidgetState createState() => _TheMiniPlayerWidgetState();
}

class _TheMiniPlayerWidgetState extends State<TheMiniPlayerWidget> {
  final DraggableScrollableController _draggableController = DraggableScrollableController();

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
            bool isExpanded = constraints.maxHeight > MediaQuery.of(context).size.height * 0.2;

            return Container(
              decoration:  BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Minimized player view
                  if (!isExpanded)
                    GestureDetector(
                      onTap: _toggleSheet,
                      child: _buildMinimizedPlayer(),
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

  Widget _buildMinimizedPlayer() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage(
              'https://play-lh.googleusercontent.com/tpok7cXkBGfq75J1xF9Lc5e7ydTix7bKN0Ehy87VP2555f8Lnmoj1KJNUlQ7-4lIYg4',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      title: Text(
        'Unknown Song',
        style: GoogleFonts.redHatDisplay(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      subtitle: Text(
        'Unknown Artist',
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
        icon: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  Widget _buildExpandedPlayerContent() {
    return SongPlayer3Screen();
  }
}
