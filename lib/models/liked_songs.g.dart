// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liked_songs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLikedSongsCollection on Isar {
  IsarCollection<LikedSongs> get likedSongs => this.collection();
}

const LikedSongsSchema = CollectionSchema(
  name: r'LikedSongs',
  id: 8303258595441867527,
  properties: {
    r'likedAt': PropertySchema(
      id: 0,
      name: r'likedAt',
      type: IsarType.dateTime,
    ),
    r'songArtists': PropertySchema(
      id: 1,
      name: r'songArtists',
      type: IsarType.string,
    ),
    r'songDuration': PropertySchema(
      id: 2,
      name: r'songDuration',
      type: IsarType.string,
    ),
    r'songImageUrl': PropertySchema(
      id: 3,
      name: r'songImageUrl',
      type: IsarType.string,
    ),
    r'songName': PropertySchema(
      id: 4,
      name: r'songName',
      type: IsarType.string,
    )
  },
  estimateSize: _likedSongsEstimateSize,
  serialize: _likedSongsSerialize,
  deserialize: _likedSongsDeserialize,
  deserializeProp: _likedSongsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _likedSongsGetId,
  getLinks: _likedSongsGetLinks,
  attach: _likedSongsAttach,
  version: '3.1.0+1',
);

int _likedSongsEstimateSize(
  LikedSongs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.songArtists.length * 3;
  {
    final value = object.songDuration;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.songImageUrl.length * 3;
  bytesCount += 3 + object.songName.length * 3;
  return bytesCount;
}

void _likedSongsSerialize(
  LikedSongs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.likedAt);
  writer.writeString(offsets[1], object.songArtists);
  writer.writeString(offsets[2], object.songDuration);
  writer.writeString(offsets[3], object.songImageUrl);
  writer.writeString(offsets[4], object.songName);
}

LikedSongs _likedSongsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LikedSongs();
  object.id = id;
  object.likedAt = reader.readDateTime(offsets[0]);
  object.songArtists = reader.readString(offsets[1]);
  object.songDuration = reader.readStringOrNull(offsets[2]);
  object.songImageUrl = reader.readString(offsets[3]);
  object.songName = reader.readString(offsets[4]);
  return object;
}

P _likedSongsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _likedSongsGetId(LikedSongs object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _likedSongsGetLinks(LikedSongs object) {
  return [];
}

void _likedSongsAttach(IsarCollection<dynamic> col, Id id, LikedSongs object) {
  object.id = id;
}

extension LikedSongsQueryWhereSort
    on QueryBuilder<LikedSongs, LikedSongs, QWhere> {
  QueryBuilder<LikedSongs, LikedSongs, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LikedSongsQueryWhere
    on QueryBuilder<LikedSongs, LikedSongs, QWhereClause> {
  QueryBuilder<LikedSongs, LikedSongs, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LikedSongsQueryFilter
    on QueryBuilder<LikedSongs, LikedSongs, QFilterCondition> {
  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> likedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'likedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      likedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'likedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> likedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'likedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> likedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'likedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songArtists',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songArtists',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songArtists',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songArtistsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songArtists',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songDuration',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songDuration',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songDuration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songDurationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> songNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> songNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> songNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> songNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> songNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition> songNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songName',
        value: '',
      ));
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterFilterCondition>
      songNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songName',
        value: '',
      ));
    });
  }
}

extension LikedSongsQueryObject
    on QueryBuilder<LikedSongs, LikedSongs, QFilterCondition> {}

extension LikedSongsQueryLinks
    on QueryBuilder<LikedSongs, LikedSongs, QFilterCondition> {}

extension LikedSongsQuerySortBy
    on QueryBuilder<LikedSongs, LikedSongs, QSortBy> {
  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortByLikedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'likedAt', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortByLikedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'likedAt', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongArtists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongArtistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songDuration', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songDuration', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> sortBySongNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.desc);
    });
  }
}

extension LikedSongsQuerySortThenBy
    on QueryBuilder<LikedSongs, LikedSongs, QSortThenBy> {
  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenByLikedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'likedAt', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenByLikedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'likedAt', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongArtists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongArtistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songDuration', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songDuration', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.desc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.asc);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QAfterSortBy> thenBySongNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.desc);
    });
  }
}

extension LikedSongsQueryWhereDistinct
    on QueryBuilder<LikedSongs, LikedSongs, QDistinct> {
  QueryBuilder<LikedSongs, LikedSongs, QDistinct> distinctByLikedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'likedAt');
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QDistinct> distinctBySongArtists(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songArtists', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QDistinct> distinctBySongDuration(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songDuration', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QDistinct> distinctBySongImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songImageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LikedSongs, LikedSongs, QDistinct> distinctBySongName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songName', caseSensitive: caseSensitive);
    });
  }
}

extension LikedSongsQueryProperty
    on QueryBuilder<LikedSongs, LikedSongs, QQueryProperty> {
  QueryBuilder<LikedSongs, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LikedSongs, DateTime, QQueryOperations> likedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'likedAt');
    });
  }

  QueryBuilder<LikedSongs, String, QQueryOperations> songArtistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songArtists');
    });
  }

  QueryBuilder<LikedSongs, String?, QQueryOperations> songDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songDuration');
    });
  }

  QueryBuilder<LikedSongs, String, QQueryOperations> songImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songImageUrl');
    });
  }

  QueryBuilder<LikedSongs, String, QQueryOperations> songNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songName');
    });
  }
}
