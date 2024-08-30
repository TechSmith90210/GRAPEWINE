import 'package:flutter/cupertino.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spot;

import '../../CustomStrings.dart';

class SearchQuery {
  final clientId = CustomStrings.clientId;
  final clientSecret = CustomStrings.clientSecret;
}

Future<void> searchFor(BuildContext context, String query) async {
  var provider = Provider.of<AccessTokenProvider>(context, listen: false);
  String? accessToken = provider.accessToken;
  var spotify = spot.SpotifyApi.withAccessToken(accessToken!);

  try {
    var searchResults = await spotify.search.get(query, types: [spot.SearchType.artist]);
    print(searchResults);
  } catch (e) {
    print(e);
  }
}
