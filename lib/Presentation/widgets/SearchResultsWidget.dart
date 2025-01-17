import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Data/Api/searchQuery.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../Providers/search_provider.dart';
import 'SearchWidgets.dart';

class SearchResultsListWidget extends StatefulWidget {
  final String query;
  const SearchResultsListWidget({
    super.key,
    required this.query,
  });

  @override
  State<SearchResultsListWidget> createState() =>
      _SearchResultsListWidgetState();
}

class _SearchResultsListWidgetState extends State<SearchResultsListWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context,listen: false);
    return FutureBuilder(
      future: SearchService().searchFor(context, widget.query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: ListView.builder(
              itemCount: provider.searchAlbumNames.length,
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
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return albumWidget(context, index);
                } else if (widget.query.isEmpty) {
                  return Center(
                    child: Text(
                      'Search Songs or find new music',
                      style: GoogleFonts.redHatDisplay(color: greyColor),
                    ),
                  );
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
    );
  }
}
