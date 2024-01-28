import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';
import '../../Data/Api/MusicApisss.dart';
import '../../Providers/albumInfo_provider.dart';

class PreviouslyPlayedCircleWidget extends StatefulWidget {
  const PreviouslyPlayedCircleWidget({super.key, required this.index});
  final int index;

  @override
  State<PreviouslyPlayedCircleWidget> createState() =>
      _PreviouslyPlayedCircleWidgetState();
}

class _PreviouslyPlayedCircleWidgetState
    extends State<PreviouslyPlayedCircleWidget> {
  late Future<void> fetchDataFuture;

  @override
  void initState() {
    super.initState();

    fetchDataFuture = fetchData(context);
  }

  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return Center(child: CircularProgressIndicator(color: purpleColor,));
          } else if (snapshot.hasError) {
            // Error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Success state
            var albumInfoProvider =
                Provider.of<AlbumInfoProvider>(context, listen: false);
            return Column(
              children: [
                Padding(
                  // padding:
                  //     const EdgeInsets.only(left: 13, right: 15, top: 15, bottom: 25),
                  padding: const EdgeInsets.only(
                      left: 13, right: 15, top: 10, bottom: 5),
                  child: Container(
                    height: 60,
                    width: 94,
                    decoration: ShapeDecoration(
                        image: DecorationImage(
                            image: NetworkImage(albumInfoProvider
                                .albumCoversProviders[widget.index]
                                .toString()),
                            fit: BoxFit.cover),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: purpleColor,
                            ),
                            borderRadius: BorderRadius.circular(47))),
                  ),
                ),
                // SizedBox(height: 10,),
                Text(
                  truncateText(
                      albumInfoProvider.albumNamesProviders[widget.index]
                          .toString(),
                      15),
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 14,
                    color: redColor,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  truncateText(
                      albumInfoProvider.artistNamesProviders[widget.index]
                          .toString(),
                      15),
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 12,
                    color: darkgreyColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            );
          }
        });
  }
}
