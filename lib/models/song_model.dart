class Song {
  final String imageUrl;   // URL of the song's image/cover
  final String songName;   // Name of the song
  final String artists;    // Artists' names as a single string
  final Duration? duration; // Duration of the song, nullable

  // Constructor to initialize the song details
  Song({
    required this.imageUrl,
    required this.songName,
    required this.artists,
    this.duration, // Nullable duration
  });

  // Method to convert the Song object into a map (useful for databases)
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'songName': songName,
      'artists': artists,
      'duration': duration?.inMilliseconds, // Store duration in milliseconds
    };
  }

  // Factory constructor to create a Song object from a map (useful for data retrieval)
  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      imageUrl: map['imageUrl'] as String,
      songName: map['songName'] as String,
      artists: map['artists'] as String,
      duration: map['duration'] != null
          ? Duration(milliseconds: map['duration'] as int)
          : null, // Handle nullable duration
    );
  }
}
