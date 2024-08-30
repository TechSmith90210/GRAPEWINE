import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/album_model.dart';

class AlbumInfo {
  List<String> artistNames = [];
  List<String> albumNames = [];
  List<String> albumCovers = [];

  Future<void> fetchAlbumInfo(String accessToken, List<String> albumIds) async {
    // logic to get the three lists of album data (artist names, album names, album covers)
    for (final albumId in albumIds) {
      final albumUrl = Uri.parse('https://api.spotify.com/v1/albums/$albumId');
      final response = await http.get(
        albumUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final fetchedAlbum = Album.fromJson(data);

        // Extract and store data
        String artistName = fetchedAlbum.artistNames.isNotEmpty
            ? fetchedAlbum.artistNames[0]
            : 'Unknown Artist'; // Handling empty artistNames
        artistNames.add(artistName);

        // Album Names
        String albumName = fetchedAlbum.albumName ?? 'Unknown Album'; // Handling null albumName
        albumNames.add(albumName);

        // Album Cover Art
        String albumCoverUrl = fetchedAlbum.albumCoverUrl.isNotEmpty
            ? fetchedAlbum.albumCoverUrl[0]
            : 'Unknown Cover'; // Handling empty albumCoverUrl
        albumCovers.add(albumCoverUrl);

        // Uncomment if you need to print the fetched data
        // print(fetchedAlbum?.albumCoverUrl[0].toString());
        // print(artistName);
        // print(albumName);
        // print(albumCoverUrl);
      } else {
        print('Failed to fetch album data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }
  }

  void getListsData() {
    // Print the filled lists
    print('Artist Names: $artistNames');
    print('Album Names: $albumNames');
    print('Album Covers: $albumCovers');
  }
}

void main() async {
  // Example usage
  // var albumInfo = AlbumInfo();
  // await albumInfo.fetchAlbumInfo('your_access_token', ['album_id1', 'album_id2']);
  // albumInfo.getListsData();
}
