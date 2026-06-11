abstract class WatchlistRemoteDataSource {
  Future<void> addToWatchlist({required String userId, required int movieId});

  Future<void> removeFromWatchlist({
    required String userId,
    required int movieId,
  });

  Future<List<int>> getWatchlist({required String userId});

  Future<bool> isInWatchlist({required String userId, required int movieId});
}
