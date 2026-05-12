import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

class Data {
  final int? movieCount;
  final int? limit;
  final int? pageNumber;
  final List<Movie>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});
}
