import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/PreviouslyPlayedCircleWidget.dart';
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
      child: Text(
        'New Releases',
        style: GoogleFonts.redHatDisplay(color: greenColor),
      ),
    ));
  }
}
