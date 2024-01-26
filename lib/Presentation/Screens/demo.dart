import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Data/Api/MusicApisss.dart';
import 'package:grapewine_music_app/models/album_model.dart';
import '../../Colors/colors.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Album? _album;

  @override
  void initState() {
    super.initState();
    fetchAndSetData();
  }

  Future<void> fetchAndSetData() async {
    await fetchData();
    setState(() {
      _album = fetchedAlbum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: eerieblackColor,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    // padding:
                    //     const EdgeInsets.only(left: 13, right: 15, top: 15, bottom: 25),
                    padding:
                    const EdgeInsets.only(left: 13, right: 15, top: 10, bottom: 5),
                    child: Container(
                      height: 60,
                      width: 94,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: NetworkImage('assets/albumcov1.jpg'),
                              fit: BoxFit.cover),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: purpleColor,
                              ),
                              borderRadius: BorderRadius.circular(47))),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  Text(
                    _album?.albumName ?? 'Loading...',
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 16,
                      color: redColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Deftones',
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 12,
                      color: darkgreyColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  _album?.albumName ?? "Loading...",
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_album != null && _album!.albumCoverUrl.isNotEmpty)
                Image.network(
                  _album!.albumCoverUrl[0].toString(),
                  height: 100,
                  width: 100,
                )
              else
                CircularProgressIndicator(), // or any other loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
