// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentlyPlayedCollection on Isar {
  IsarCollection<RecentlyPlayed> get recentlyPlayeds => this.collection();
}

const RecentlyPlayedSchema = CollectionSchema(
  name: r'RecentlyPlayed',
  id: 2614409739199134941,
  properties: {
    r'playedAt': PropertySchema(
      id: 0,
      name: r'playedAt',
      type: IsarType.dateTime,
    ),
    r'songArtists': PropertySchema(
      id: 1,
      name: r'songArtists',
      type: IsarType.string,
    ),
    r'songImageUrl': PropertySchema(
      id: 2,
      name: r'songImageUrl',
      type: IsarType.string,
    ),
    r'songName': PropertySchema(
      id: 3,
      name: r'songName',
      type: IsarType.string,
    )
  },
  estimateSize: _recentlyPlayedEstimateSize,
  serialize: _recentlyPlayedSerialize,
  deserialize: _recentlyPlayedDeserialize,
  deserializeProp: _recentlyPlayedDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentlyPlayedGetId,
  getLinks: _recentlyPlayedGetLinks,
  attach: _recentlyPlayedAttach,
  version: '3.1.0+1',
);

int _recentlyPlayedEstimateSize(
  RecentlyPlayed object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.songArtists.length * 3;
  bytesCount += 3 + object.songImageUrl.length * 3;
  bytesCount += 3 + object.songName.length * 3;
  return bytesCount;
}

void _recentlyPlayedSerialize(
  RecentlyPlayed object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.playedAt);
  writer.writeString(offsets[1], object.songArtists);
  writer.writeString(offsets[2], object.songImageUrl);
  writer.writeString(offsets[3], object.songName);
}

RecentlyPlayed _recentlyPlayedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentlyPlayed();
  object.id = id;
  object.playedAt = reader.readDateTime(offsets[0]);
  object.songArtists = reader.readString(offsets[1]);
  object.songImageUrl = reader.readString(offsets[2]);
  object.songName = reader.readString(offsets[3]);
  return object;
}

P _recentlyPlayedDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentlyPlayedGetId(RecentlyPlayed object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _recentlyPlayedGetLinks(RecentlyPlayed object) {
  return [];
}

void _recentlyPlayedAttach(
    IsarCollection<dynamic> col, Id id, RecentlyPlayed object) {
  object.id = id;
}

extension RecentlyPlayedQueryWhereSort
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QWhere> {
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentlyPlayedQueryWhere
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QWhereClause> {
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterWhereClause> idBetween(
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

extension RecentlyPlayedQueryFilter
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QFilterCondition> {
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      playedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      playedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      playedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      playedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songArtistsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songArtists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songArtistsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songArtists',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songArtistsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songArtists',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songArtistsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songArtists',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameEqualTo(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameLessThan(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameBetween(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameEndsWith(
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songName',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songName',
        value: '',
      ));
    });
  }
}

extension RecentlyPlayedQueryObject
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QFilterCondition> {}

extension RecentlyPlayedQueryLinks
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QFilterCondition> {}

extension RecentlyPlayedQuerySortBy
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QSortBy> {
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> sortByPlayedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortByPlayedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortBySongArtists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortBySongArtistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortBySongImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortBySongImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> sortBySongName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortBySongNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.desc);
    });
  }
}

extension RecentlyPlayedQuerySortThenBy
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QSortThenBy> {
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> thenByPlayedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenByPlayedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenBySongArtists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenBySongArtistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songArtists', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenBySongImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenBySongImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songImageUrl', Sort.desc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> thenBySongName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenBySongNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.desc);
    });
  }
}

extension RecentlyPlayedQueryWhereDistinct
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QDistinct> {
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QDistinct> distinctByPlayedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playedAt');
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QDistinct> distinctBySongArtists(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songArtists', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QDistinct>
      distinctBySongImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songImageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QDistinct> distinctBySongName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songName', caseSensitive: caseSensitive);
    });
  }
}

extension RecentlyPlayedQueryProperty
    on QueryBuilder<RecentlyPlayed, RecentlyPlayed, QQueryProperty> {
  QueryBuilder<RecentlyPlayed, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecentlyPlayed, DateTime, QQueryOperations> playedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playedAt');
    });
  }

  QueryBuilder<RecentlyPlayed, String, QQueryOperations> songArtistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songArtists');
    });
  }

  QueryBuilder<RecentlyPlayed, String, QQueryOperations>
      songImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songImageUrl');
    });
  }

  QueryBuilder<RecentlyPlayed, String, QQueryOperations> songNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songName');
    });
  }
}
