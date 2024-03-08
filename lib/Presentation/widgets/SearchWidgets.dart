import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/search_provider.dart';

Widget ArtistWidget = ListTile(
  title: Text(
    provider.searchArtistNames[index],
    style: GoogleFonts.redHatDisplay(color: whiteColor),
  ),
  subtitle: Text(
    'Artist',
    style: GoogleFonts.redHatDisplay(color: greyColor),
  ),
  leading: Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      image: DecorationImage(
          image: imageUrl.isNotEmpty
              ? NetworkImage(imageUrl.toString())
          as ImageProvider<Object>
              : const AssetImage(
              'assets/icons8-user-96.png'),
          fit: BoxFit.cover),
    ),
  ),
  trailing: const Icon(Icons.arrow_forward_ios_rounded),
);

class ArtistWidgetTree extends StatefulWidget {
  const ArtistWidgetTree({super.key});

  @override
  State<ArtistWidgetTree> createState() => _ArtistWidgetTreeState();
}

class _ArtistWidgetTreeState extends State<ArtistWidgetTree> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    return const Placeholder();
  }
}
