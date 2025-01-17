import 'package:flutter/cupertino.dart';
import 'package:grapewine_music_app/Providers/accessToken_provider.dart';
import 'package:grapewine_music_app/Providers/album_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spot;
import '../../CustomStrings.dart';
import '../../Providers/search_provider.dart';
import '../../models/album_model.dart';
import 'MusicApisss.dart';

class SearchService {
  final clientId = CustomStrings.clientId;
  final clientSecret = CustomStrings.clientSecret;

  // Function to search for albums
// Function to search for albums and populate songs
  Future<void> searchFor(BuildContext context, String query) async {
    var provider = Provider.of<AccessTokenProvider>(context, listen: false);
    String? accessToken = provider.accessToken;

    var spotify = spot.SpotifyApi.withAccessToken(accessToken!);

    try {
      var searchResults = await spotify.search.get(query, types: [
        spot.SearchType.album, // Searching for albums
      ]);
      var searchPage = await searchResults.getPage(30).then((value) {
        return value.expand((e) => e.items!).toList();
      });

      var searchProvider = Provider.of<SearchProvider>(context, listen: false);
      var albumProvider = Provider.of<AlbumProvider>(context, listen: false);

      //<------------------------------- ALBUMS -------------------------------------->

      // Extract album details from search results
      List<spot.AlbumSimple> albums = searchPage
          .map((item) => item as spot.AlbumSimple)
          .whereType<spot.AlbumSimple>()
          .toList();

      List<AlbumModel> albumModels = [];

      for (var album in albums) {
        String albumType = album.albumType.toString();
        String displayType = "";

        // Check album type and assign the appropriate label
        if (albumType == "AlbumType.album") {
          displayType = "Album";
        } else if (albumType == "AlbumType.single") {
          displayType = "Single";
        } else if (albumType == "AlbumType.compilation") {
          displayType = "Compilation";
        } else {
          displayType = albumType; // For any other type, use the raw value
        }

        // Fetch album tracks from the Spotify API
        var albumTracks =
            await spotify.albums.tracks(album.id!).all(); // Await the Future

        // Extract the album image (assuming all tracks in an album have the same image)
        String albumImageUrl = album.images!.isNotEmpty
            ? album.images![0].url.toString()
            : ''; // Use the first image of the album

        // Now that albumTracks is a list, you can map over it
        List<AlbumSong> albumSongs = albumTracks.map((track) {
          return AlbumSong(
            id: track.id.toString(),
            name: track.name ?? 'Unknown', // Default if name is null
            artists: track.artists != null
                ? track.artists!.map((artist) => artist.name).join(', ')
                : 'Unknown Artist', // Default if artists are null
            imageUrl: albumImageUrl, // Use the same album image for every track
            trackNumber: track.trackNumber
          );
        }).toList();

        // Create AlbumModel instance for each album
        AlbumModel albumModel = AlbumModel(
          id: album.id.toString(),
          name: album.name!,
          artist: album.artists!.map((e) => e.name).join(', '),
          imageUrl: album.images?.isNotEmpty == true
              ? album.images![0].url.toString()
              : '',
          type: displayType,
          songs: albumSongs, // Now the songs list is populated
          releaseDate: album.releaseDate!,
        );

        albumModels.add(albumModel);
      }

      // Update the provider with the list of AlbumModels
      searchProvider.setAlbums(albumModels);
    } catch (e) {
      print('Error during search: $e');
    }
  }

  // Function to handle search and data fetching in a single call
  Future<void> searchforData(BuildContext context, String query) async {
    await fetchData(context); // Ensure data is fetched first (if needed)
    await searchFor(context, query); // Then perform the search
  }
}
