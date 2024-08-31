import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/Screens/search_screen2.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: blackColor ,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: greyColor,
          width: 0.3,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: whiteColor),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: searchController,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w700,
                  color: greyColor,
                  fontSize: 15,
                ),
              ),
              cursorColor: purpleColor,
              style: GoogleFonts.redHatDisplay(
                fontWeight: FontWeight.w700,
                color: whiteColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage2()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
