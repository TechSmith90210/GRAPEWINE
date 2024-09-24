class PlaylistModel {
  final String playlistName;
  final String? imageUrl;
  final int? id;
  final List<PlaylistSongModel> songs;

  PlaylistModel({
    this.id,
    List<PlaylistSongModel>? songs,
    this.imageUrl,
    required this.playlistName,
  }) : songs = songs ?? [];
}

class PlaylistSongModel {
  final int playlistId;
  int positionInPlaylist;
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
