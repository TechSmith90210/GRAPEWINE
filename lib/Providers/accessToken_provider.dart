import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../CustomStrings.dart';

class AccessTokenProvider with ChangeNotifier {
  String? _accessToken;

  String? get accessToken => _accessToken;

  // Fetch the access token if not available
  Future<String?> getAccessToken() async {
    _accessToken ??= await fetchAccessToken();
    return _accessToken;
  }

  // Save the access token
  void saveAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  Future<String?> fetchAccessToken() async {
    const clientId = CustomStrings.clientId;
    const clientSecret = CustomStrings.clientSecret;

    final tokenUrl = Uri.parse('https://accounts.spotify.com/api/token');
    final response = await http.post(
      tokenUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final accessToken = data['access_token'];
      // print('Access Token: $accessToken');
      saveAccessToken(accessToken);
      return accessToken;
    } else {
      print('Failed to get access token. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
      return null;
    }
  }
}
