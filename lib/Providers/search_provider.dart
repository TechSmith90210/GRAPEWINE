import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spot;
import 'package:flutter/material.dart';

import '../Data/Api/MusicApisss.dart';
import 'accessToken_provider.dart';

class SearchProvider with ChangeNotifier {
  //artists
  List<String> _searchArtistNames = [];
  List<String> get searchArtistNames => _searchArtistNames;
  void setArtistNames(List<String> newArtistNames) {
    _searchArtistNames = newArtistNames;
    notifyListeners();
  }

  List<String> _searchArtistImages = [];
  List<String> get searchArtistImages => _searchArtistImages;
  void setArtistImages(List<String> newArtistImages) {
    _searchArtistImages = newArtistImages;
    notifyListeners();
  }

  //tracks
  List<String> _searchTrackNames = [];
  List<String> get searchTrackNames => _searchTrackNames;
  void getTrackNames(List<String> newTrackNames) {
    _searchTrackNames = newTrackNames;
    notifyListeners();
  }

  List<String> _searchTrackImages = [];
  List<String> get searchTrackImages => _searchTrackImages;
  void getTrackImages(List<String> newTrackImages) {
    _searchTrackImages = newTrackImages;
    notifyListeners();
  }

  //albums
  List<String> _searchAlbumNames = [];
  List<String> get searchAlbumNames => _searchAlbumNames;
  void getAlbumNames(List<String> newAlbumNames) {
    _searchAlbumNames = newAlbumNames;
    notifyListeners();
  }

  List<String> _searchAlbumImages = [];
  List<String> get searchAlbumImages => _searchAlbumImages;
  void getAlbumImages(List<String> newAlbumImages) {
    _searchAlbumImages = newAlbumImages;
    notifyListeners();
  }
}

Future<void> searchFor(BuildContext context, String query) async {
  var provider = Provider.of<AccessTokenProvider>(context, listen: false);
  String accessToken = provider.accessToken;

  var spotify = spot.SpotifyApi.withAccessToken(accessToken);

  try {
    var searchResults = await spotify.search.get(query, types: [
      spot.SearchType.artist,
      spot.SearchType.track,
      spot.SearchType.album
    ]);
    var searchPage = await searchResults.getPage(5).then((value) {
      return value.expand((e) => e.items!).toList();
    });
    List<dynamic> albums = searchPage.sublist(0, 5);

    // print(albums);
    // print(artistss);
    // print(trackss);
    // print(searchPage);

    //<------------------------------- ARTISTS -------------------------------------->
    // Extract artists and its details from the search results
    List<dynamic> artistss = searchPage.sublist(5, 10);
    List<spot.Artist> artists = artistss
        .map((item) => item as spot.Artist)
        .whereType<spot.Artist>()
        .toList();

    List<String> searchArtistImages = [];
    List<String> searchArtistNames = [];

    var searchProvider = Provider.of<SearchProvider>(context, listen: false);

    for (var artist in artists) {
      searchArtistNames.add(artist.name!);

      if (artist.images != null && artist.images!.isNotEmpty) {
        // Use the first image if available
        searchArtistImages.add(artist.images![0].url.toString());
      } else {
        // case where there are no images
        searchArtistImages.add('');
      }
    }
    searchProvider.setArtistNames(searchArtistNames);
    searchProvider.setArtistImages(searchArtistImages);

    // print(searchProvider.searchArtistImages);

    //<------------------------------- TRACKS -------------------------------------->
    //Extract tracks and its details from search results
    List<dynamic> trackss = searchPage.sublist(10, 15);
    List<spot.Track> tracks = trackss
        .map((item) => item as spot.Track)
        .whereType<spot.Track>()
        .toList();

    List<String> searchTrackNames = [];
    List<String> searchTrackImages = [];

    for (var track in tracks) {
      searchTrackNames.add(track.name!);

      if (track.album?.images != null && track.album!.images!.isNotEmpty) {
        // Use the first image if available
        searchTrackImages.add(track.album!.images![0].url.toString());
      } else {
        // case where there are no images
        searchTrackImages.add('');
      }
    }
    searchProvider.getTrackNames(searchTrackNames);
    searchProvider.getTrackImages(searchTrackImages);

    //<------------------------------- ALBUMS -------------------------------------->
    // Extract albums and its details from search results
    List<dynamic> albumsss = searchPage.sublist(0, 5);
    List<spot.AlbumSimple> albumss = albumsss
        .map((item) => item as spot.AlbumSimple)
        .whereType<spot.AlbumSimple>()
        .toList();

    List<String> searchAlbumNames = [];
    List<String> searchAlbumImages = [];

    for (var album in albumss) {
      searchAlbumNames.add(album.name!);

      if (album.images != null && album.images!.isNotEmpty) {
        // Use the first image if available
        searchAlbumImages.add(album.images![0].url.toString());
      } else {
        // case where there are no images
        searchAlbumImages.add('');
      }
    }
    searchProvider.getAlbumNames(searchAlbumNames);
    searchProvider.getAlbumImages(searchAlbumImages);

    // print(searchProvider.searchAlbumNames);
    // print(searchProvider.searchAlbumImages);

  } catch (e) {
    print(e);
  }
}

Future<void> searchforData(BuildContext context, String query) async {
  await fetchData(context);
  await searchFor(context, query);
}
