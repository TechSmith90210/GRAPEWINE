import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spot;
import 'package:http/http.dart' as http;
import '../../models/album_model.dart';

class MusicDataService {
  Future<void> fetchNewReleases(
      String accessToken, BuildContext context) async {
    var provider = Provider.of<NewReleasesProvider>(context, listen: false);
    var spotify = spot.SpotifyApi.withAccessToken(accessToken);

    try {
      var newReleases =
          await spotify.browse.newReleases(country: spot.Market.IN).all(20);

      // Ensure albumIds is a non-null list of Strings (removing null values)
      List<String> albumIds =
          newReleases.map((album) => album.id ?? '').toList();
      albumIds.removeWhere((id) => id.isEmpty); // Remove empty strings

      // Ensure albumNames is a non-null list of Strings (removing null values)
      List<String> albumNames =
          newReleases.map((album) => album.name ?? '').toList();
      albumNames.removeWhere((name) => name.isEmpty); // Remove empty strings

      // Prepare albumArtists (List<List<String?>>) without nullable values
      List<List<String>> allAlbumArtists = [];
      await Future.forEach(newReleases, (album) {
        var artistNames =
            album.artists?.map((artist) => artist.name ?? '').toList() ?? [];
        artistNames.removeWhere((name) => name.isEmpty); // Remove empty strings
        allAlbumArtists.add(artistNames);
      });

      // Prepare albumCovers and albumTypes (List<String?>) without nullable values
      List<String> albumCovers = [];
      List<String> albumTypes = []; // Initialize the albumTypes list
      for (var albumId in albumIds) {
        await spotify.albums.get(albumId).then((album) {
          var images = album.images?.map((e) => e.url).toList() ?? [];
          albumCovers.add(images.isNotEmpty
              ? images[0].toString()
              : ''); // Fallback to empty string if no cover found

          // Fetch the album type (e.g., "album", "single", etc.)
          String albumType = album.type ?? 'Unknown'; // Default to 'Unknown' if no type found
          albumTypes.add(albumType); // Add album type to the list
        });
      }

      // Update the provider with the fetched data
      provider.updateNewReleasesData(
          albumIds, albumNames, allAlbumArtists, albumCovers,albumTypes);

      // print(albumIds.toString());
      print('loaded new releases');
    } catch (e) {
      print('Error fetching new releases: $e');
    }
  }

  List<String> artistNames = [];
  List<String> albumNames = [];
  List<String> albumCovers = [];
  List<String> albumArtists =[];
  List<String> albumTypes =[];


}
