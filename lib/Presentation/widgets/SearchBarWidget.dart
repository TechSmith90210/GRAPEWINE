import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      // isFullScreen: true,
      viewBackgroundColor: blackColor,
      headerTextStyle: GoogleFonts.redHatDisplay(color: whiteColor),
      viewLeading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          )),
      viewTrailing: [Icon(Icons.search, color: Colors.white)],
      builder: (context, controller) {
        return SearchBar(
          // elevation: MaterialStatePropertyAll(2),
          // overlayColor: MaterialStatePropertyAll(Color(0xFFE2DFD2)),
          // shadowColor: MaterialStatePropertyAll(Color(0xFF979797)),
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 14.0)),
          onTap: () => controller.openView(),
          onChanged: (_) => controller.closeView(controller.text),
          onSubmitted: (value) {
            print(value.toString());
          },
          leading: const Icon(Icons.search, color: Color(0xFF151515)),
          hintText: 'Search',
          textStyle: const MaterialStatePropertyAll(
              TextStyle(color: Color(0xFF151515))),
          backgroundColor: MaterialStatePropertyAll(whiteColor),
        );
      },
      suggestionsBuilder: (context, controller) {
        return List<ListTile>.generate(15, (index) {
          final String item = 'item $index';
          return ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(3)),
            ),
            title: Text(
              'Blue Lips',
              style: GoogleFonts.redHatDisplay(color: whiteColor),
            ),
            subtitle: Text(
              'Album • Schoolboy Q',
              style: GoogleFonts.redHatDisplay(color: greyColor),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      },
    );
  }
}
