import 'package:moives/features/movies/data/mappers/movies_mapper.dart';
import 'package:moives/features/movies/data/models/response/movie_suggestions/movie_suggestions_data_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_suggestions/movie_suggestions_data.dart';

extension MovieSuggestionsDataMapper on MovieSuggestionsDataDto {
  MovieSuggestionsData toData() {
    return MovieSuggestionsData(
      movieCount: movieCount,
      movies: movies?.map((dto) => dto.toMovie()).toList(),
    );
  }
}
