import 'package:isar/isar.dart';

part 'playlist.g.dart'; // Required for code generation

@collection
class Playlist {
  Id id = Isar.autoIncrement;

  late final String playlistName;
  String? imageUrl;
  String? description;
  DateTime creationDate = DateTime.now();
  DateTime lastUpdated = DateTime.now();
  int? totalDurationInSeconds;
  DateTime? lastPlayed;

  final songs = IsarLinks<PlaylistSong>();

  // Constructor updated to include id as an optional parameter.
  Playlist({
    this.id = Isar.autoIncrement, // Allow id to be passed or auto-generated
    required this.playlistName,
    this.imageUrl,
    this.description,
    this.totalDurationInSeconds,
    this.lastPlayed,
  });
}

@collection
class PlaylistSong {
  Id id = Isar.autoIncrement;

  int? positionInPlaylist;
  late String songName;
  late String songArtists;
  late String songImageUrl;
  String? songId;
  int? durationInSeconds;

  final playlist = IsarLink<Playlist>(); // Backlink to the Playlist

  // Constructor updated to include id as an optional parameter.
  PlaylistSong({
    this.id = Isar.autoIncrement, // Allow id to be passed or auto-generated
    required this.songName,
    required this.songArtists,
    required this.songImageUrl,
    this.songId,
    this.positionInPlaylist,
    this.durationInSeconds,
  });
}
