import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Data/services/local_helper.dart';
import 'package:provider/provider.dart';

import '../../models/song.dart';
import '../widgets/AppBarWidget.dart';
import 'library_screen.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localHelper = Provider.of<LocalHelper>(context);
    return Scaffold(
        appBar: AppBarWidget(
          title: 'Recently Played',
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: localHelper.getRecentlyPlayedSongs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Recently Played Songs'));
            } else {
              final songs = snapshot.data!;
              return Container(
                margin: const EdgeInsets.only(bottom: 35),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: double.infinity,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return buildRecentlyPlayedWidget(
                      cx: context,
                      imageUrl: song.imageUrl,
                      songTitle: song.songName,
                      songArtist: song.artists,
                    );
                  },
                  itemCount: songs.length,
                ),
              );
            }
          },
        ));
  }
}
