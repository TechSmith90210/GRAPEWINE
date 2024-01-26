// album_model.dart

class Album {
  final String albumName;
  final List<String> artistNames;
  final List<String> albumCoverUrl;

  Album({
    required this.albumName,
    required this.artistNames,
    required this.albumCoverUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    final albumName = json['name'];
    final List<dynamic> artists = json['artists'];
    final List<dynamic> images = json['images'];
    final artistNames =
        artists.map((artist) => artist['name'] as String).toList();
    final albumCoverUrl =
        images.map((image) => image['url'] as String).toList();

    return Album(
      albumName: albumName,
      artistNames: artistNames,
      albumCoverUrl: albumCoverUrl,
    );
  }
}
