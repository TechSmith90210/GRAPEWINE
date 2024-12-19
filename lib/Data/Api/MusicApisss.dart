import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Data/Api/fetchAlbumInfo.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:grapewine_music_app/Providers/albumInfo_provider.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:provider/provider.dart';
import '../../models/album_model.dart';
import 'fetchNewReleases.dart';

Album? fetchedAlbum;

Future<void> fetchData(BuildContext context) async {
  final accessTokenProvider = Provider.of<AccessTokenProvider>(context, listen: false);
  final accessToken = await accessTokenProvider.getAccessToken();
  final newProvider = Provider.of<NewReleasesProvider>(context, listen: false);

  if (accessToken != null) {
    var albumInfo = AlbumInfo();
    var albumDataProvider = Provider.of<AlbumInfoProvider>(context, listen: false);

    await albumInfo.fetchAlbumInfo(accessToken, AlbumInfoProvider.albumIds);

    albumDataProvider.updateArtistNames(albumInfo.artistNames);
    albumDataProvider.updateAlbumNames(albumInfo.albumNames);
    albumDataProvider.updateAlbumCovers(albumInfo.albumCovers);

    FetchNewReleases().fetchNewReleases(accessToken, context);

  }
}

Future<String?> fetchSearchAccessToken(BuildContext context) async {
  final accessTokenProvider = Provider.of<AccessTokenProvider>(context, listen: false);
  final accessToken = await accessTokenProvider.getAccessToken();

  if (accessToken != null) {
    // Handle the access token if needed
    return accessToken;
  }
}

