import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Providers/search_provider.dart';
import 'package:provider/provider.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late Future<void> fetchDataFuture;

  @override
  void initState() {
    fetchDataFuture = searchforData(context, 'Nirvana');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      // var imageUrl =
                      //     provider.searchArtistImages[index].toString();
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: purpleColor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return SearchResultsWidget(context, index);
                      }
                      return null;
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: purpleColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget ArtistWidget(BuildContext context, int index) {
  var provider = Provider.of<SearchProvider>(context);
  var imageUrl = provider.searchArtistImages[index].toString();
  return ListTile(
    title: Text(
      provider.searchArtistNames[index],
      style: GoogleFonts.redHatDisplay(color: whiteColor),
    ),
    subtitle: Text(
      'Artist',
      style: GoogleFonts.redHatDisplay(color: greyColor),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
                : const AssetImage('assets/icons8-user-96.png'),
            fit: BoxFit.cover),
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
  );
}

Widget TrackWidget(BuildContext context, int index) {
  var provider = Provider.of<SearchProvider>(context);
  var imageUrl = provider.searchTrackImages[index].toString();
  return ListTile(
    title: Text(
      provider.searchTrackNames[index],
      style: GoogleFonts.redHatDisplay(color: whiteColor),
    ),
    subtitle: Text(
      'Track',
      style: GoogleFonts.redHatDisplay(color: greyColor),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
                : const AssetImage('assets/icons8-user-96.png'),
            fit: BoxFit.cover),
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
  );
}

Widget AlbumWidget(BuildContext context, int index) {
  var provider = Provider.of<SearchProvider>(context);
  var imageUrl = provider.searchAlbumImages[index].toString();
  return ListTile(
    title: Text(
      provider.searchAlbumNames[index],
      style: GoogleFonts.redHatDisplay(color: whiteColor),
    ),
    subtitle: Text(
      'Album',
      style: GoogleFonts.redHatDisplay(color: greyColor),
    ),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
          image: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl.toString()) as ImageProvider<Object>
              : const AssetImage('assets/icons8-album-96.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    trailing: const Icon(Icons.arrow_forward_ios_rounded),
  );
}

Widget SearchResultsWidget(BuildContext context, int index) {
  // Check if index is within valid range
  if (index < 0 || index > 14) {
    return SizedBox(); // Return an empty widget or handle as needed
  }

  // All tracks, albums, artists widgets
  int internalIndex;

  if (index <= 4) {
    internalIndex = index;
    return TrackWidget(context, internalIndex);
  } else if (index > 4 && index <= 9) {
    internalIndex = index - 5; // Adjusted the offset here
    return AlbumWidget(context, internalIndex);
  } else {
    internalIndex = index - 10; // Adjusted the offset here
    return ArtistWidget(context, internalIndex);
  }
}
