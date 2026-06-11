import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/datasource/remote/history_remote_data_source.dart';
import '../../domain/datasource/remote/watch_list_remote_data_source.dart';
import '../../domain/repositories/watch_list_repository.dart';

@Injectable(as: WatchlistRepository)
class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource watchlistDataSource;
  final HistoryRemoteDataSource historyDataSource;

  WatchlistRepositoryImpl({
    required this.watchlistDataSource,
    required this.historyDataSource,
  });

  @override
  Future<Either<Failure, void>> addToWatchlist(
      {required String userId, required int movieId}) async {
    try {
      await watchlistDataSource.addToWatchlist(
          userId: userId, movieId: movieId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWatchlist(
      {required String userId, required int movieId}) async {
    try {
      await watchlistDataSource.removeFromWatchlist(
          userId: userId, movieId: movieId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getWatchlist(
      {required String userId}) async {
    try {
      final list = await watchlistDataSource.getWatchlist(userId: userId);
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isInWatchlist(
      {required String userId, required int movieId}) async {
    try {
      final result = await watchlistDataSource.isInWatchlist(
          userId: userId, movieId: movieId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToHistory(
      {required String userId, required int movieId}) async {
    try {
      await historyDataSource.addToHistory(userId: userId, movieId: movieId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getHistory(
      {required String userId}) async {
    try {
      final list = await historyDataSource.getHistory(userId: userId);
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}