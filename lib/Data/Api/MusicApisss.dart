import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:grapewine_music_app/Data/Api/fetchAlbumInfo.dart';
import 'package:grapewine_music_app/Data/Api/fetchNewReleases.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:grapewine_music_app/Providers/albumInfo_provider.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../CustomStrings.dart';
import '../../Providers/accessToken_provider.dart';
import '../../Providers/accessToken_provider.dart';
import '../../models/album_model.dart';

Album? fetchedAlbum;

Future<void> fetchData(BuildContext context) async {
  final clientId = CustomStrings.clientId;
  final clientSecret = CustomStrings.clientSecret;

  // getting the access token
  final tokenUrl = Uri.parse('https://accounts.spotify.com/api/token');
  final response = await http.post(
    tokenUrl,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
    },
    body: {'grant_type': 'client_credentials'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final accessToken = data['access_token'];
    print('Access Token: $accessToken');

    //save the accesstoken in provider for further uses
    var accessTokenProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    accessTokenProvider.saveAccessToken(accessToken);

    // print(accessTokenProvider.accessToken);

    var albumInfo = AlbumInfo();
    var albumDataProvider = Provider.of<AlbumInfoProvider>(context,
        listen: false); //initializing the provider
    // var newReleasesProvider = Provider.of<NewReleasesProvider>(context);

    //fetching the previously played
    await albumInfo.fetchAlbumInfo(accessToken, AlbumInfoProvider.albumIds
        // newReleasesProvider.albumIds
        ); // fetching the album data & filling the three lists with data

    // albumInfo.getListsData(); // print the fetched Data for debugging

    // print(albumInfo.albumCovers);
    // assigning the fetched lists from the fetchAlbumInfo() method to the provider's lists
    albumDataProvider.updateArtistNames(albumInfo.artistNames); //artist Names
    albumDataProvider.updateAlbumNames(albumInfo.albumNames); // album Names
    albumDataProvider.updateAlbumCovers(albumInfo.albumCovers); // album Covers

    // await albumInfo.fetchAlbumInfo(accessToken, newReleasesProvider.albumIds);
    //
    // await newReleasesProvider.updateArtistNames(albumInfo.albumNames);
    // print(newReleasesProvider.albumArtists);
    //fetching the New Releases
    // Future.delayed(Duration(seconds: 5),() {

    // },);
    // Timer(Duration(seconds: 5), () { FetchNewReleases fetchNewReleases = FetchNewReleases();
    // fetchNewReleases.fetchNewReleases(accessToken, context); });

    // print(albumDataProvider.albumCoversProviders.toString());
    // print(albumDataProvider.albumNamesProviders.toString());

    return accessToken;
  } else {
    print('Failed to get access token. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

Future<void> fetchSearchAccessToken(BuildContext context) async {
  final clientId = CustomStrings.clientId;
  final clientSecret = CustomStrings.clientSecret;

  // getting the access token
  final tokenUrl = Uri.parse('https://accounts.spotify.com/api/token');
  final response = await http.post(
    tokenUrl,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
    },
    body: {'grant_type': 'client_credentials'},
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final accessToken = data['access_token'];
    print('Access Token: $accessToken');

    //save the accesstoken in provider for further uses
    var accessTokenProvider =
        Provider.of<AccessTokenProvider>(context, listen: false);
    accessTokenProvider.saveAccessToken(accessToken);

    // print(accessTokenProvider.accessToken);

    return accessToken;
  } else {
    print('Failed to get access token. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
