import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/watch_list_repository.dart';

@injectable
class AddToWatchlistUseCase extends BaseUseCase<void, int> {
  final WatchlistRepository repository;

  AddToWatchlistUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) {
    return repository.addToWatchlist(params);
  }
}
