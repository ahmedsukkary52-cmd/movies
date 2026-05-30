import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, void>> addToWatchlist(int movieId);

  Future<Either<Failure, void>> removeFromWatchlist(int movieId);

  Future<Either<Failure, List<int>>> getWatchlist();

  Future<Either<Failure, bool>> isInWatchlist(int movieId);

  Future<Either<Failure, void>> addToHistory(int movieId);

  Future<Either<Failure, List<int>>> getHistory();
}
