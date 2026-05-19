import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/errors/exceptions.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/features/movies/domain/datasource/remote/movies_remote_data_source.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';
import 'package:moives/features/movies/domain/repositories/movies_repository.dart';

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MoviesList>> getMovies(
      {int page = 1, String? genre}) async {
    try {
      var movieListResponse = await remoteDataSource.getMoviesList(
          page: page, genre: genre);
      return Right(movieListResponse);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      {required int id}) async {
    try {
      var response = await remoteDataSource.getMovieDetails(id: id);
      return Right(response);
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return left(NetworkFailure(e.message));
    }
  }
}
