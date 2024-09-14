// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSongModelCollection on Isar {
  IsarCollection<SongModel> get songModels => this.collection();
}

const SongModelSchema = CollectionSchema(
  name: r'SongModel',
  id: 5804096728791725223,
  properties: {
    r'artists': PropertySchema(
      id: 0,
      name: r'artists',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 1,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'songName': PropertySchema(
      id: 2,
      name: r'songName',
      type: IsarType.string,
    )
  },
  estimateSize: _songModelEstimateSize,
  serialize: _songModelSerialize,
  deserialize: _songModelDeserialize,
  deserializeProp: _songModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _songModelGetId,
  getLinks: _songModelGetLinks,
  attach: _songModelAttach,
  version: '3.1.0+1',
);

int _songModelEstimateSize(
  SongModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.artists.length * 3;
  bytesCount += 3 + object.imageUrl.length * 3;
  bytesCount += 3 + object.songName.length * 3;
  return bytesCount;
}

void _songModelSerialize(
  SongModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.artists);
  writer.writeString(offsets[1], object.imageUrl);
  writer.writeString(offsets[2], object.songName);
}

SongModel _songModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SongModel();
  object.artists = reader.readString(offsets[0]);
  object.id = id;
  object.imageUrl = reader.readString(offsets[1]);
  object.songName = reader.readString(offsets[2]);
  return object;
}

P _songModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _songModelGetId(SongModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _songModelGetLinks(SongModel object) {
  return [];
}

void _songModelAttach(IsarCollection<dynamic> col, Id id, SongModel object) {
  object.id = id;
}

extension SongModelQueryWhereSort
    on QueryBuilder<SongModel, SongModel, QWhere> {
  QueryBuilder<SongModel, SongModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SongModelQueryWhere
    on QueryBuilder<SongModel, SongModel, QWhereClause> {
  QueryBuilder<SongModel, SongModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SongModel, SongModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterWhereClause> idBetween(
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

extension SongModelQueryFilter
    on QueryBuilder<SongModel, SongModel, QFilterCondition> {
  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artists',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artists',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> artistsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artists',
        value: '',
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition>
      artistsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artists',
        value: '',
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameEqualTo(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameGreaterThan(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameLessThan(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameBetween(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameStartsWith(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameEndsWith(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameContains(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameMatches(
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

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition> songNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songName',
        value: '',
      ));
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterFilterCondition>
      songNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songName',
        value: '',
      ));
    });
  }
}

extension SongModelQueryObject
    on QueryBuilder<SongModel, SongModel, QFilterCondition> {}

extension SongModelQueryLinks
    on QueryBuilder<SongModel, SongModel, QFilterCondition> {}

extension SongModelQuerySortBy on QueryBuilder<SongModel, SongModel, QSortBy> {
  QueryBuilder<SongModel, SongModel, QAfterSortBy> sortByArtists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artists', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> sortByArtistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artists', Sort.desc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> sortBySongName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> sortBySongNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.desc);
    });
  }
}

extension SongModelQuerySortThenBy
    on QueryBuilder<SongModel, SongModel, QSortThenBy> {
  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenByArtists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artists', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenByArtistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artists', Sort.desc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenBySongName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.asc);
    });
  }

  QueryBuilder<SongModel, SongModel, QAfterSortBy> thenBySongNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songName', Sort.desc);
    });
  }
}

extension SongModelQueryWhereDistinct
    on QueryBuilder<SongModel, SongModel, QDistinct> {
  QueryBuilder<SongModel, SongModel, QDistinct> distinctByArtists(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artists', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SongModel, SongModel, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SongModel, SongModel, QDistinct> distinctBySongName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songName', caseSensitive: caseSensitive);
    });
  }
}

extension SongModelQueryProperty
    on QueryBuilder<SongModel, SongModel, QQueryProperty> {
  QueryBuilder<SongModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SongModel, String, QQueryOperations> artistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artists');
    });
  }

  QueryBuilder<SongModel, String, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<SongModel, String, QQueryOperations> songNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songName');
    });
  }
}
