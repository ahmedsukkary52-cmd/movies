import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/watch_list_params.dart';
import '../repositories/watch_list_repository.dart';

@injectable
class IsInWatchlistUseCase extends BaseUseCase<bool, WatchlistParams> {
  final WatchlistRepository repository;
  IsInWatchlistUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(WatchlistParams params) {
    return repository.isInWatchlist(
        userId: params.userId, movieId: params.movieId);
  }
}