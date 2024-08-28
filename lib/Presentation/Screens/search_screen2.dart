import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Data/Api/MusicApisss.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchBarWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchResultsWidget.dart';
import 'package:grapewine_music_app/Presentation/widgets/SearchSongWidget.dart';

import '../../Providers/search_provider.dart';
import '../widgets/SearchWidgets.dart';

class SearchPage2 extends StatefulWidget {
  const SearchPage2({super.key});

  @override
  State<SearchPage2> createState() => _SearchPage2State();
}

class _SearchPage2State extends State<SearchPage2> {
  TextEditingController searchController = TextEditingController();
  bool isClicked = false;
  String query = '';
  late FocusNode _focusNode;
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    fetchData(context);

    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isTextFieldFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        foregroundColor: whiteColor,
        // leading: Icon(Icons.arrow_back),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: eerieblackColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: isClicked ? purpleColor : greyColor, width: 0.3)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
              // keyboardAppearance: Brightness.dark,
              focusNode: _focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Song',
                hintStyle: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w700,
                    color: greyColor,
                    fontSize: 15),
              ),
              cursorColor: purpleColor,
              style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w700, color: whiteColor),
              controller: searchController,
              onChanged: (value) {
                print('Input: $value');
              },
              onSubmitted: (value) {
                setState(() {});
                query = searchController.text;
                if (query.isEmpty) {
                  isClicked = !isClicked;
                } else {
                  isClicked = true;
                }
              },
            ),
          ),
        ),
        actions: [
          if (_isTextFieldFocused)
            IconButton(
                onPressed: () {
                  setState(() {});
                  query = searchController.text;
                  if (query.isEmpty) {
                    isClicked = !isClicked;
                    query = "songs";
                  } else {
                    isClicked = true;
                  }
                },
                icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (isClicked
              ? SearchResultsListWidget(
                  query: query,
                )
              : Center(
                  child: Text(
                    'Search or find new music',
                    style: GoogleFonts.redHatDisplay(color: greyColor),
                  ),
                ))
        ],
      ),
    );
  }
}
