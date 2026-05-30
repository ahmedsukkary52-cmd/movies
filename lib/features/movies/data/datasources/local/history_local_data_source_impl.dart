import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/datasource/local/history_local_data_source.dart';

@Injectable(as: HistoryLocalDataSource)
class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  final SharedPreferences prefs;

  HistoryLocalDataSourceImpl(this.prefs);

  static const String _key = 'history';

  @override
  Future<void> addToHistory(int movieId) async {
    final list = prefs.getStringList(_key) ?? [];
    list.remove(movieId.toString());
    list.insert(0, movieId.toString());
    await prefs.setStringList(_key, list);
  }

  @override
  Future<List<int>> getHistory() async {
    final list = prefs.getStringList(_key) ?? [];
    return list.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> clearHistory() async {
    await prefs.remove(_key);
  }
}
