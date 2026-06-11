import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/errors/failure.dart';
import 'package:moives/core/usecases/base_use_case.dart';
import 'package:moives/features/movies/domain/entities/response/movie_suggestions/movie_suggestions.dart';
import 'package:moives/features/movies/domain/repositories/movies_repository.dart';

@injectable
class MovieSuggestionsUseCase extends BaseUseCase<MovieSuggestions, int> {
  MoviesRepository repository;

  MovieSuggestionsUseCase({required this.repository});

  @override
  Future<Either<Failure, MovieSuggestions>> call(int params) {
    return repository.getMovieSuggestions(id: params);
  }
}
