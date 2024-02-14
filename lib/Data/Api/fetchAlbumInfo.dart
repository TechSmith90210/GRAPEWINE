import 'dart:convert';
import 'package:grapewine_music_app/Data/Api/fetchNewReleases.dart';
import 'package:http/http.dart' as http;
import '../../models/album_model.dart';
import 'MusicApisss.dart';

class AlbumInfo {
  List<String> artistNames = [];
  List<String> albumNames = [];
  List<String> albumCovers = [];

  Future<void> fetchAlbumInfo(String accessToken, List<String> albumIds) async {
    // logic to get the three lists of album data (artist names, album names, album covers)
    for (final i in albumIds) {
      // print(i);
      final albumurl = Uri.parse('https://api.spotify.com/v1/albums/$i');
      final response = await http.get(
        albumurl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // print(data);

        fetchedAlbum = Album.fromJson(data);
        // print(fetchedAlbum?.albumCoverUrl[0].toString());
        String? artistName = fetchedAlbum?.artistNames[0].toString();
        // print(artistName);
        //print it
        artistNames.add(artistName!);

        //album Names
        String? albumName = fetchedAlbum?.albumName.toString();
        albumNames.add(albumName!);

        //album Cover Art
        String? albumCoverUrl = fetchedAlbum?.albumCoverUrl[0].toString();
        albumCovers.add(albumCoverUrl!);

        // FetchNewReleases fetchNewReleases=FetchNewReleases();
        // fetchNewReleases.fetchNewReleases(accessToken);
        // for (final j in artistNames) {
        //   print(j);
        // }
        // print(artistNames.toString());
      } else {
        print(
            'Failed to fetch public data. Status code: ${response.statusCode}');
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
  // fetchData();
}
