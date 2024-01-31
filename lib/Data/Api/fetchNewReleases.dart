import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/album_model.dart';
import 'MusicApisss.dart';

class FetchNewReleases {
  // https://api.spotify.com/v1/browse/new-releases
  Future<void> fetchNewReleases(String accessToken) async {
    final albumurl = Uri.parse('https://api.spotify.com/v1/browse/new-releases');
    final response = await http.get(
      albumurl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);

      // fetchedAlbum = Album.fromJson(data);
      // print(fetchedAlbum?.albumCoverUrl[0].toString());
    } // Add this closing bracket
  }
}
