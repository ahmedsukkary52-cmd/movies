import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/core/usecases/base_use_case.dart';
import 'package:moives/core/usecases/movie_params.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';
import 'package:moives/features/movies/domain/repositories/movies_repository.dart';

@injectable
class GetMovieUseCase extends BaseUseCase<MoviesList, MovieParams> {
  final MoviesRepository repository;
  GetMovieUseCase(this.repository);
  @override
  Future<Either<Failure, MoviesList>> call(MovieParams params) {
    return repository.getMovies(
        page: params.page, genre: params.genre, query: params.query);
  }
}