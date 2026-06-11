import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';
import 'package:moives/features/movies/domain/entities/response/movie_suggestions/movie_suggestions.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesList> getMoviesList({int page, String? genre, String? query});

  Future<MovieDetails> getMovieDetails({required int id});

  Future<MovieSuggestions> getMovieSuggestions({required int id});
}
