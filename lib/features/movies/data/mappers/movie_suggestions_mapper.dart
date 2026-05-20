import 'package:moives/features/movies/data/mappers/meta_mapper.dart';
import 'package:moives/features/movies/data/mappers/movie_suggestions_data_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_suggestions/movie_suggestions_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_suggestions/movie_suggestions.dart';

extension MovieSuggestionsMapper on MovieSuggestionsDto {
  MovieSuggestions toMovie() {
    return MovieSuggestions(
      statusMessage: statusMessage,
      status: statusMessage,
      meta: meta?.toMeta(),
      data: data?.toData(),
    );
  }
}
