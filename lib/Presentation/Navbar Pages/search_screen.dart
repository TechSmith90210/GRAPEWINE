import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Presentation/widgets/AppBarWidget.dart';

import '../../Colors/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'SEARCH'),
      body: Center(
        child: Text(
          'Search Page',
          style: GoogleFonts.redHatDisplay(color: whiteColor),
        ),
      ),
    );
  }
}
