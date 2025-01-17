import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:provider/provider.dart';
import 'musicDataService.dart';

Future<void> fetchData(BuildContext context) async {
  final accessTokenProvider =
      Provider.of<AccessTokenProvider>(context, listen: false);
  final accessToken = await accessTokenProvider.getAccessToken();

  if (accessToken != null) {
    MusicDataService().fetchNewReleases(accessToken, context);
  }
}

Future<String?> fetchSearchAccessToken(BuildContext context) async {
  final accessTokenProvider =
      Provider.of<AccessTokenProvider>(context, listen: false);
  final accessToken = await accessTokenProvider.getAccessToken();

  if (accessToken != null) {
    // Handle the access token if needed
    return accessToken;
  }
  return null;
}
