import 'package:dartz/dartz.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/core/usecases/base_use_case.dart';
import 'package:moives/core/usecases/no_pramas.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';
import 'package:moives/features/movies/domain/repositories/movies_repository.dart';

class GetMovieUseCase extends BaseUseCase<List<Movie> , NoParams> {
  final MoviesRepository repository;
  GetMovieUseCase(this.repository);
  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) {
    return repository.getMovies();
  }
}