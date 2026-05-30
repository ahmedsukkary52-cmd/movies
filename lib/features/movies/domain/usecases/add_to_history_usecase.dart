import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/watch_list_repository.dart';

@injectable
class AddToHistoryUseCase extends BaseUseCase<void, int> {
  final WatchlistRepository repository;

  AddToHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) {
    return repository.addToHistory(params);
  }
}
