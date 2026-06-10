abstract class HistoryRemoteDataSource {
  Future<void> addToHistory({required String userId, required int movieId});

  Future<List<int>> getHistory({required String userId});

  Future<void> clearHistory({required String userId});
}
