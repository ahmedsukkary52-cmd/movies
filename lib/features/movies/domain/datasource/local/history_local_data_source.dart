abstract class HistoryLocalDataSource {
  Future<void> addToHistory(int movieId);

  Future<List<int>> getHistory();

  Future<void> clearHistory();
}
