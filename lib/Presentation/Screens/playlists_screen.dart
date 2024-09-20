import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: whiteColor,
        ),
        title: 'Playlists',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline_rounded),
            color: greyColor,
          )
        ],
      ),
    );
  }
}
