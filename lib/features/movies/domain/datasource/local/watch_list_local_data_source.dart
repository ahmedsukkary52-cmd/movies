abstract class WatchlistLocalDataSource {
  Future<void> addToWatchlist(int movieId);

  Future<void> removeFromWatchlist(int movieId);

  Future<List<int>> getWatchlist();

  Future<bool> isInWatchlist(int movieId);
}
