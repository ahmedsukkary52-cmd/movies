import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/watch_list_repository.dart';

@injectable
class IsInWatchlistUseCase extends BaseUseCase<bool, int> {
  final WatchlistRepository repository;

  IsInWatchlistUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(int params) {
    return repository.isInWatchlist(params);
  }
}
