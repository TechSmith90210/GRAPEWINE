import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

class SearchSongWidget extends StatefulWidget {
  const SearchSongWidget({super.key});

  @override
  State<SearchSongWidget> createState() => _SearchSongWidgetState();
}

class _SearchSongWidgetState extends State<SearchSongWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          print(value);
        },
        onSubmitted: (value) {
          print(value);
        },
      ),
    );
  }
}
