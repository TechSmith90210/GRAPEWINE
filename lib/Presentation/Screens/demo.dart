import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Providers/albumInfo_provider.dart';
import 'package:provider/provider.dart';

import '../../Data/Api/MusicApisss.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // late AlbumInfo albumInfo;
  late Future<void> fetchDataFuture;

  @override
  void initState() {
    super.initState();

    fetchDataFuture = fetchData(context);
  }

  // Future<void> fetchDataAndBuild() async {
  //   await fetchData(context);
  //   var provider = Provider.of<AlbumInfoProvider>(context, listen: false);
  //   print(provider.artistNamesProviders.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: eerieblackColor,
          ),
          child: FutureBuilder(
            future: fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading state
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Error state
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // Success state
                var provider =
                    Provider.of<AlbumInfoProvider>(context, listen: false);
                return Center(
                    child: Text(
                  provider.artistNamesProviders.toString(),
                  style: GoogleFonts.redHatDisplay(color: whiteColor),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
