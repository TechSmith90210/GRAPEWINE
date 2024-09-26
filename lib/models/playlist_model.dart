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
  int? playlistId;
  int? positionInPlaylist;
  final String songName;
  final String songArtists;
  final String songImageUrl;

  PlaylistSongModel(
      { this.playlistId,
      this.positionInPlaylist,
      required this.songName,
      required this.songArtists,
      required this.songImageUrl});
}
