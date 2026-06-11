import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, void>> addToWatchlist(
      {required String userId, required int movieId});

  Future<Either<Failure, void>> removeFromWatchlist(
      {required String userId, required int movieId});

  Future<Either<Failure, List<int>>> getWatchlist({required String userId});

  Future<Either<Failure, bool>> isInWatchlist(
      {required String userId, required int movieId});

  Future<Either<Failure, void>> addToHistory(
      {required String userId, required int movieId});

  Future<Either<Failure, List<int>>> getHistory({required String userId});
}