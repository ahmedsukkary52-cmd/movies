import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/core/usecases/base_use_case.dart';
import 'package:moives/features/movies/domain/entities/response/movie_details/movie_details.dart';
import 'package:moives/features/movies/domain/repositories/movies_repository.dart';

@injectable
class MovieDetailsUseCase extends BaseUseCase<MovieDetails, int> {
  final MoviesRepository repository;

  MovieDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, MovieDetails>> call(int params) {
    return repository.getMovieDetails(id: params);
  }
}
