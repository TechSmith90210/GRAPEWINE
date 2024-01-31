class NewReleases {
  Albums albums;

  NewReleases({
    required this.albums,
  });
}

class Albums {
  String href;
  List<Item> items;
  int limit;
  String next;
  int offset;
  dynamic previous;
  int total;

  Albums({
    required this.href,
    required this.items,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });
}

class Item {
  AlbumTypeEnum albumType;
  List<Artist> artists;
  List<String> availableMarkets;
  ExternalUrls externalUrls;
  String href;
  String id;
  List<Image> images;
  String name;
  DateTime releaseDate;
  ReleaseDatePrecision releaseDatePrecision;
  int totalTracks;
  AlbumTypeEnum type;
  String uri;

  Item({
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.type,
    required this.uri,
  });
}

enum AlbumTypeEnum { ALBUM, EP, SINGLE }

class Artist {
  ExternalUrls externalUrls;
  String href;
  String id;
  String name;
  ArtistType type;
  String uri;

  Artist({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });
}

class ExternalUrls {
  String spotify;

  ExternalUrls({
    required this.spotify,
  });
}

enum ArtistType { ARTIST }

class Image {
  int height;
  String url;
  int width;

  Image({
    required this.height,
    required this.url,
    required this.width,
  });
}

enum ReleaseDatePrecision { DAY }
