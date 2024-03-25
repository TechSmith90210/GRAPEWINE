import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spot;
import 'package:flutter/material.dart';

import '../Data/Api/MusicApisss.dart';
import 'accessToken_provider.dart';

class SearchProvider with ChangeNotifier {
  //selected song details
  String _selectedSongName = '';
  String get selectedSongName => _selectedSongName;
  void setSongName(String newSongName) {
    _selectedSongName = newSongName;
    notifyListeners();
  }

  //selected song album name
  String _selectedSongAlbum = '';
  String get selectedSongAlbum => _selectedSongAlbum;
  void setSongAlbumName(String newAlbumName) {
    _selectedSongAlbum = newAlbumName;
    notifyListeners();
  }

  String _selectedSongArtist = '';
  String get selectedSongArtist => _selectedSongArtist;
  void setSongArtist(String newArtist) {
    _selectedSongArtist = newArtist;
    notifyListeners();
  }

  String _selectedSongDetails = '';
  String get selectedSongDetails => _selectedSongDetails;
  void setSongDetails(String newSongDetails) {
    _selectedSongDetails = newSongDetails;
    notifyListeners();
  }

  String _selectedSongImage = '';
  String get selectedSongImage => _selectedSongImage;
  void setSongImage(String newSongImage) {
    _selectedSongImage = newSongImage;
    notifyListeners();
  }

  //Search Page Initials
  bool _isClicked = false;
  bool get isClicked => _isClicked;
  void setClick() {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  String _query = '';
  String get query => _query;
  void setQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

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

  List<String> _searchTrackArtists = [];
  List<String> get searchTrackArtists => _searchTrackArtists;
  void setTrackArtists(List<String> newTrackArtists) {
    _searchTrackArtists = newTrackArtists;
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

  List<String> _searchAlbumArtists = [];
  List<String> get searchAlbumArtists => _searchAlbumArtists;
  void setAlbumArtists(List<String> newAlbumArtists) {
    _searchAlbumArtists = newAlbumArtists;
    notifyListeners();
  }
}

Future<void> searchFor(BuildContext context, String query) async {
  var provider = Provider.of<AccessTokenProvider>(context, listen: false);
  String accessToken = provider.accessToken;

  var spotify = spot.SpotifyApi.withAccessToken(accessToken);

  try {
    var searchResults = await spotify.search.get(query, types: [
      // spot.SearchType.artist,
      spot.SearchType.track,
      // spot.SearchType.album
    ]);
    var searchPage = await searchResults.getPage(30).then((value) {
      return value.expand((e) => e.items!).toList();
    });
    // print(searchPage);
    // print(albums);
    // print(artistss);
    // print(trackss);
    // print(searchPage);

    var searchProvider = Provider.of<SearchProvider>(context, listen: false);

    //<------------------------------- ARTISTS -------------------------------------->
    // Extract artists and its details from the search results
    // List<dynamic> artistss = searchPage.sublist(5, 10);
    // List<spot.Artist> artists = artistss
    //     .map((item) => item as spot.Artist)
    //     .whereType<spot.Artist>()
    //     .toList();
    //
    // List<String> searchArtistImages = [];
    // List<String> searchArtistNames = [];
    //
    //
    // for (var artist in artists) {
    //   searchArtistNames.add(artist.name!);
    //
    //   if (artist.images != null && artist.images!.isNotEmpty) {
    //     // Use the first image if available
    //     searchArtistImages.add(artist.images![0].url.toString());
    //   } else {
    //     // case where there are no images
    //     searchArtistImages.add('');
    //   }
    // }
    // searchProvider.setArtistNames(searchArtistNames);
    // searchProvider.setArtistImages(searchArtistImages);

    // print(searchProvider.searchArtistImages);

    //<------------------------------- TRACKS -------------------------------------->
    //Extract tracks and its details from search results
    // List<dynamic> trackss = searchPage.sublist(10, 15);
    List<spot.Track> tracks = searchPage
        .map((item) => item as spot.Track)
        .whereType<spot.Track>()
        .toList();

    List<String> searchTrackNames = [];
    List<String> searchTrackImages = [];
    List<String> searchTrackArtists = [];
    List<String> searchTrackAlbumNames = [];

    for (var track in tracks) {
      searchTrackNames.add(track.name!);

      if (track.album?.images != null && track.album!.images!.isNotEmpty) {
        // Use the first image if available
        searchTrackImages.add(track.album!.images![0].url.toString());
      } else {
        // case where there are no images
        searchTrackImages.add('');
      }
      searchTrackArtists
          .add(track.artists!.map((e) => e.name!.toString()).toString());
      // searchTrackAlbumNames.add(track.album!.name.toString());
    }
    searchProvider.getTrackNames(searchTrackNames);
    searchProvider.getTrackImages(searchTrackImages);
    searchProvider.setTrackArtists(searchTrackArtists);
    // print(searchProvider._searchAlbumNames);
    // print(searchTrackArtists);

    //<------------------------------- ALBUMS -------------------------------------->
    // Extract albums and its details from search results
    // List<dynamic> albumsss = searchPage.sublist(0, 5);
    // List<spot.AlbumSimple> albumss = albumsss
    //     .map((item) => item as spot.AlbumSimple)
    //     .whereType<spot.AlbumSimple>()
    //     .toList();
    //
    // List<String> searchAlbumNames = [];
    // List<String> searchAlbumImages = [];
    // List<String> searchAlbumArtists = [];
    // for (var album in albumss) {
    //   searchAlbumNames.add(album.name!);
    //
    //   if (album.images != null && album.images!.isNotEmpty) {
    //     // Use the first image if available
    //     searchAlbumImages.add(album.images![0].url.toString());
    //   } else {
    //     // case where there are no images
    //     searchAlbumImages.add('');
    //   }
    //   searchAlbumArtists.add(album.artists!.map((e) => e.name).toString());
    // }
    // searchProvider.getAlbumNames(searchAlbumNames);
    // searchProvider.getAlbumImages(searchAlbumImages);
    // searchProvider.setAlbumArtists(searchAlbumArtists);
    // print(searchProvider.searchAlbumArtists);
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
