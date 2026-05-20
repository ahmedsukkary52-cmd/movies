// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_suggestions_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSuggestionsDataDto _$MovieSuggestionsDataDtoFromJson(
  Map<String, dynamic> json,
) => MovieSuggestionsDataDto(
  movieCount: (json['movie_count'] as num?)?.toInt(),
  movies: (json['movies'] as List<dynamic>?)
      ?.map((e) => MoviesDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MovieSuggestionsDataDtoToJson(
  MovieSuggestionsDataDto instance,
) => <String, dynamic>{
  'movie_count': instance.movieCount,
  'movies': instance.movies,
};
