import 'package:dartz/dartz.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure , List<Movie>>> getMovies();
}