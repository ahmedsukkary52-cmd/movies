import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/watch_list_params.dart';
import '../repositories/watch_list_repository.dart';

@injectable
class RemoveFromWatchlistUseCase extends BaseUseCase<void, WatchlistParams> {
  final WatchlistRepository repository;
  RemoveFromWatchlistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(WatchlistParams params) {
    return repository.removeFromWatchlist(
        userId: params.userId, movieId: params.movieId);
  }
}