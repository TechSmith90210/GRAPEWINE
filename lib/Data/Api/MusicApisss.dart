import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Data/Api/fetchAlbumInfo.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:grapewine_music_app/Providers/albumInfo_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../CustomStrings.dart';
import '../../models/album_model.dart';

Album? fetchedAlbum;

Future<void> fetchData(BuildContext context) async {
  final accessTokenProvider = Provider.of<AccessTokenProvider>(context, listen: false);
  final accessToken = await accessTokenProvider.getAccessToken(context);

  if (accessToken != null) {
    var albumInfo = AlbumInfo();
    var albumDataProvider = Provider.of<AlbumInfoProvider>(context, listen: false);

    await albumInfo.fetchAlbumInfo(accessToken, AlbumInfoProvider.albumIds);

    albumDataProvider.updateArtistNames(albumInfo.artistNames);
    albumDataProvider.updateAlbumNames(albumInfo.albumNames);
    albumDataProvider.updateAlbumCovers(albumInfo.albumCovers);
  }
}

Future<String?> fetchSearchAccessToken(BuildContext context) async {
  final accessTokenProvider = Provider.of<AccessTokenProvider>(context, listen: false);
  final accessToken = await accessTokenProvider.getAccessToken(context);

  if (accessToken != null) {
    // Handle the access token if needed
    return accessToken;
  }
}

