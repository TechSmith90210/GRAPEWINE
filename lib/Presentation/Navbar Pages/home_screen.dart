import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/PreviouslyPlayedCircleWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: 'HOME'),
        body: Container(
          // color: redColor,
          // margin: const EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Previously Played',
                style: GoogleFonts.redHatDisplay(
                  color: greenColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PreviouslyPlayedCircleWidget();
                  },
                ),
              ),
              Text(
                'New Releases',
                style: GoogleFonts.redHatDisplay(
                  color: greenColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ));
  }
}
