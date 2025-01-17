class AlbumModel {
  final String id; // Album ID from the API
  final String name; // Album name
  final String artist; // Primary artist or band
  final String? imageUrl; // URL of the album cover image
  final String type; // Album type: "album", "single", or "compilation"
  final String releaseDate; // Release date of the album
  final int? totalDurationInSeconds; // Total duration of all songs in the album
  final List<AlbumSong> songs; // List of songs in the album

  // Constructor
  AlbumModel({
    required this.id,
    required this.name,
    required this.artist,
    this.imageUrl,
    required this.type,
    required this.releaseDate,
    this.totalDurationInSeconds,
    required this.songs,
  });
}

class AlbumSong {
  final String id; // Song ID from the API
  final String name; // Song name
  final String artists; // Comma-separated list of artists
  final String imageUrl; // URL of the song's image (if available)
  final int? durationInSeconds; // Duration of the song in seconds
  final int? trackNumber; // Position of the song in the album

  // Constructor
  AlbumSong({
    required this.id,
    required this.name,
    required this.artists,
    required this.imageUrl,
    this.durationInSeconds,
    this.trackNumber,
  });
}
