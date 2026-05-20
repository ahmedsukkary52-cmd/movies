import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

class MovieSuggestionsData {
  final int? movieCount;
  final List<Movie>? movies;

  MovieSuggestionsData({this.movieCount, this.movies});
}
