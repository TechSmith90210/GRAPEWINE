import 'package:flutter/cupertino.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spot;

class FetchNewReleases {
  Future<void> fetchNewReleases(String accessToken, BuildContext context) async {
    var provider = Provider.of<NewReleasesProvider>(context, listen: false);
    var spotify = spot.SpotifyApi.withAccessToken(accessToken);

    try {
      var newReleases = await spotify.browse.newReleases(country: spot.Market.IN).all();

      // Ensure albumIds is a non-null list of Strings (removing null values)
      List<String> albumIds = newReleases.map((album) => album.id ?? '').toList();
      albumIds.removeWhere((id) => id.isEmpty); // Remove empty strings

      // Ensure albumNames is a non-null list of Strings (removing null values)
      List<String> albumNames = newReleases.map((album) => album.name ?? '').toList();
      albumNames.removeWhere((name) => name.isEmpty); // Remove empty strings

      // Prepare albumArtists (List<List<String?>>) without nullable values
      List<List<String>> allAlbumArtists = [];
      await Future.forEach(newReleases, (album) {
        var artistNames = album.artists?.map((artist) => artist.name ?? '').toList() ?? [];
        artistNames.removeWhere((name) => name.isEmpty); // Remove empty strings
        allAlbumArtists.add(artistNames);
      });

      // Prepare albumCovers (List<String?>) without nullable values
      List<String> albumCovers = [];
      for (var albumId in albumIds) {
        await spotify.albums.get(albumId).then((album) {
          var images = album.images?.map((e) => e.url).toList() ?? [];
          albumCovers.add(images.isNotEmpty ? images[0].toString() : ''); // Fallback to empty string if no cover found
        });
      }

      // Update the provider with the fetched data
      provider.updateAlbumData(albumIds, albumNames, allAlbumArtists, albumCovers);

      print(albumNames.toString());

    } catch (e) {
      print('Error fetching new releases: $e');
    }
  }
}
