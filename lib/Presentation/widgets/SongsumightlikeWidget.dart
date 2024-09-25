import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/Screens/music/library/liked_songs_screen.dart';
import 'package:grapewine_music_app/Presentation/widgets/MiniPlayerWidget.dart';
import 'package:grapewine_music_app/models/song_model.dart';
import 'package:provider/provider.dart';
import '../../Providers/newFinds_provider.dart';

class SongsYouMightLikeSection extends StatefulWidget {
  const SongsYouMightLikeSection({super.key});

  @override
  State<SongsYouMightLikeSection> createState() =>
      _SongsYouMightLikeSectionState();
}

class _SongsYouMightLikeSectionState extends State<SongsYouMightLikeSection> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewFindsProvider>(context);

    // Number of items in each column
    int itemsPerColumn = 3;

    // Number of columns needed
    int columns = (provider.albumNames.length / itemsPerColumn).ceil();

    return Container(
      height: 250, // Adjust this height as needed
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            columns,
            (columnIndex) => Container(
              width: 300, // Set width of each column
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  itemsPerColumn,
                  (rowIndex) {
                    int itemIndex = columnIndex * itemsPerColumn + rowIndex;
                    if (itemIndex < provider.albumNames.length) {
                      return SongTileWidget(index: itemIndex);
                    } else {
                      return SizedBox
                          .shrink(); // Handle case where there are fewer items
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SongTileWidget extends StatelessWidget {
  final int index;

  const SongTileWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewFindsProvider>(context);

    return Bounceable(
      onTap: () {
        Song song = Song(
            imageUrl: provider.albumCovers[index].toString(),
            songName: provider.albumNames[index].toString(),
            artists: provider.albumArtists[index].toString());
        handleSongTap(context: context, song: song);
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
          tileColor: blackColor.withOpacity(0.25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(provider.albumCovers[index].toString()),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          title: Text(
            truncateText(provider.albumNames[index].toString(), 20),
            style: GoogleFonts.redHatDisplay(
              color: whiteColor,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          subtitle: Text(
            provider.albumArtists[index].toString(),
            style: GoogleFonts.redHatDisplay(
              color: greyColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: whiteColor,
                size: 20,
              )),
        ),
      ),
    );
  }
}
