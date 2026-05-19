import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesList> getMoviesList({int page, String? genre});

  Future<MovieDetails> getMovieDetails({required int id});
}
