import 'package:dartz/dartz.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';
import 'package:moives/features/movies/domain/entities/response/movie_suggestions/movie_suggestions.dart';

abstract class MoviesRepository {
  Future<Either<Failure, MoviesList>> getMovies(
      {int page, String? genre, String? query});

  Future<Either<Failure, MovieDetails>> getMovieDetails({required int id});

  Future<Either<Failure, MovieSuggestions>> getMovieSuggestions(
      {required int id});
}