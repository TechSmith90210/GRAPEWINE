class PlaylistModel {
  final String playlistName;
  final String? imageUrl;
  final int? Id;

  PlaylistModel({
    this.Id,
    this.imageUrl,
    required this.playlistName,
  });
}

void main() {
  PlaylistModel playlistModel = PlaylistModel(playlistName: 'hello');
  print(playlistModel.playlistName);
}

class PlaylistSongModel {
  final int playlistId;
  final int positionInPlaylist;
  final String songName;
  final String songArtists;
  final String songImageUrl;

  PlaylistSongModel(
      {required this.playlistId,
      required this.positionInPlaylist,
      required this.songName,
      required this.songArtists,
      required this.songImageUrl});
}
