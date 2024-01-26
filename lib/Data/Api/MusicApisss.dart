// main.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../CustomStrings.dart';
import '../../models/album_model.dart';

Album? fetchedAlbum;

Future<void> fetchData() async {
  final clientId = CustomStrings.clientId;
  final clientSecret = CustomStrings.clientSecret;

  final tokenUrl = Uri.parse('https://accounts.spotify.com/api/token');
  final response = await http.post(
    tokenUrl,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
    },
    body: {'grant_type': 'client_credentials'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final accessToken = data['access_token'];
    print('Access Token: $accessToken');

    await fetchPublicData(accessToken);
  } else {
    print('Failed to get access token. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

Future<void> fetchPublicData(String accessToken) async {
  String albumId = '0QEZpylv3YWsleH9U0ijWE?si=fV3TluQaRBOVqOazO40ydw';
  final albumApiUrl = Uri.parse('https://api.spotify.com/v1/albums/$albumId');

  final response = await http.get(
    albumApiUrl,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    print(data);

    fetchedAlbum = Album.fromJson(data);
    print(fetchedAlbum?.albumCoverUrl[0].toString());
  } else {
    print('Failed to fetch public data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
