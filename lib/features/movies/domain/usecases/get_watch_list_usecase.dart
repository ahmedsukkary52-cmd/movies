import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/no_params.dart';
import '../repositories/watch_list_repository.dart';

@injectable
class GetWatchlistUseCase extends BaseUseCase<List<int>, NoParams> {
  final WatchlistRepository repository;

  GetWatchlistUseCase(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) {
    return repository.getWatchlist();
  }
}
