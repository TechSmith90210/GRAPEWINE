import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:grapewine_music_app/Providers/newReleases_provider.dart';
import 'package:grapewine_music_app/models/newReleases_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/album_model.dart';
import 'MusicApisss.dart';
import 'package:spotify/spotify.dart' as spot;

Images? newStuff;

class FetchNewReleases {
  // https://api.spotify.com/v1/browse/new-releases
  Future<void> fetchNewReleases(
      String accessToken, BuildContext context) async {
    var provider = Provider.of<NewReleasesProvider>(context, listen: false);

    var spotify = spot.SpotifyApi.withAccessToken(accessToken);
    try {
      var newReleases = await spotify.browse.newReleases().all();

      //get album ids and then fetch images for each id in the list
      var albumids =
          await newReleases.map((album) => album.id).take(7).toList();
      // provider.updateIds(albumids);
      var albumNames =
          await newReleases.map((album) => album.name).take(7).toList();
      // provider.updateNames(albumNames);

      // get album artists
      var allAlbumArtists = <List<String?>>[];
      await Future.forEach(newReleases, (album) {
        var artistNames =
            album.artists?.map((artist) => artist.name).take(7).toList() ?? [];
        allAlbumArtists.add(artistNames);
      });
      // print(allAlbumArtists);

      // get album covers
      List<String?> covers = [];
      for (var albumId in albumids) {
        await spotify.albums.get(albumId!).then((album) {
          var images = album.images?.map((e) => e.url).toList() ?? [];
          covers.add(images.isNotEmpty ? images[0].toString() : '');
        });
      }

      //get artist names
      // var artists;
      // var albumArtistNames = await newReleases.map(
      //   (e) {
      //     var artist = e.artists?.map((e) => e.name) ?? [];
      //     artists=artist;
      //   },
      // );
      //
      // print(artists);

      // print(covers);
      // provider.updateCovers(covers);
      print(provider.albumCovers);
      // print(provider.albumIds);
      // print(albumids);
      // print(albumNames);
      // print(albumCovers);
      // print(albumArtists);
    } catch (e) {
      // Handle errors
      print('Error fetching new releases: $e');
    }

    // final albumurl =
    //     Uri.parse('https://api.spotify.com/v1/browse/new-releases');
    // final response = await http.get(
    //   albumurl,
    //   headers: {'Authorization': 'Bearer $accessToken'},
    // );
    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> data = json.decode(response.body);
    //   print(data);
    //
    //   // fetchedAlbum = Album.fromJson(data);
    //
    //   // print(fetchedAlbum!.albumCoverUrl[0].toString());
    //   // String? albumCoverUrl = fetchedAlbum?.albumCoverUrl[0].toString();
    //
    //   // try {
    //   //   newStuff = Images.fromJson(data);
    //   //   var albumCovers = newStuff!.url?[0].toString();
    //   //   print(albumCovers);
    //   // } catch (e) {
    //   //   print(e);
    //   // }
    // }
  }
}
