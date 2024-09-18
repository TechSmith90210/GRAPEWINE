import 'package:isar/isar.dart';

part 'liked_songs.g.dart';

@Collection()
class LikedSongs{
  Id? id ; // unique identifer for each liked song

  late String songName; // name of the song
  late String songArtists; // song artists name
  late String songImageUrl; // link of the song's image

  late String? songDuration; // duration of song

  late DateTime likedAt; // time which the song was liked at, used for sorting the likedsongs list

  // LikedSongs({required this.songName, required this.songArtists, required this.songImageUrl});
}