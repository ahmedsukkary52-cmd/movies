import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/datasource/local/watch_list_local_data_source.dart';

@Injectable(as: WatchlistLocalDataSource)
class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final SharedPreferences prefs;

  WatchlistLocalDataSourceImpl(this.prefs);

  static const String _key = 'watchlist';

  @override
  Future<void> addToWatchlist(int movieId) async {
    final list = prefs.getStringList(_key) ?? [];
    if (!list.contains(movieId.toString())) {
      list.add(movieId.toString());
      await prefs.setStringList(_key, list);
    }
  }

  @override
  Future<void> removeFromWatchlist(int movieId) async {
    final list = prefs.getStringList(_key) ?? [];
    list.remove(movieId.toString());
    await prefs.setStringList(_key, list);
  }

  @override
  Future<List<int>> getWatchlist() async {
    final list = prefs.getStringList(_key) ?? [];
    return list.map((e) => int.parse(e)).toList();
  }

  @override
  Future<bool> isInWatchlist(int movieId) async {
    final list = prefs.getStringList(_key) ?? [];
    return list.contains(movieId.toString());
  }
}
