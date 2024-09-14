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
    r'songId': PropertySchema(
      id: 1,
      name: r'songId',
      type: IsarType.long,
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
  return bytesCount;
}

void _recentlyPlayedSerialize(
  RecentlyPlayed object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.playedAt);
  writer.writeLong(offsets[1], object.songId);
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
  object.songId = reader.readLong(offsets[1]);
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
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentlyPlayedGetId(RecentlyPlayed object) {
  return object.id;
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
  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
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
    Id value, {
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
    Id lower,
    Id upper, {
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
      songIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterFilterCondition>
      songIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy> thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QAfterSortBy>
      thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
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

  QueryBuilder<RecentlyPlayed, RecentlyPlayed, QDistinct> distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
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

  QueryBuilder<RecentlyPlayed, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }
}
