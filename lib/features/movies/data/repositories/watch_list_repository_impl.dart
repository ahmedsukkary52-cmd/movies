import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/datasource/local/history_local_data_source.dart';
import '../../domain/datasource/local/watch_list_local_data_source.dart';
import '../../domain/repositories/watch_list_repository.dart';

@Injectable(as: WatchlistRepository)
class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource watchlistDataSource;
  final HistoryLocalDataSource historyDataSource;

  WatchlistRepositoryImpl({
    required this.watchlistDataSource,
    required this.historyDataSource,
  });

  @override
  Future<Either<Failure, void>> addToWatchlist(int movieId) async {
    try {
      await watchlistDataSource.addToWatchlist(movieId);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWatchlist(int movieId) async {
    try {
      await watchlistDataSource.removeFromWatchlist(movieId);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getWatchlist() async {
    try {
      final list = await watchlistDataSource.getWatchlist();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isInWatchlist(int movieId) async {
    try {
      final result = await watchlistDataSource.isInWatchlist(movieId);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToHistory(int movieId) async {
    try {
      await historyDataSource.addToHistory(movieId);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getHistory() async {
    try {
      final list = await historyDataSource.getHistory();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
