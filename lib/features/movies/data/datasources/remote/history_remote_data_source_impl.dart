import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/datasource/remote/history_remote_data_source.dart';

@Injectable(as: HistoryRemoteDataSource)
class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addToHistory({
    required String userId,
    required int movieId,
  }) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    final list = List<int>.from(doc.data()?['history'] ?? []);
    list.remove(movieId);
    list.insert(0, movieId);
    await _firestore.collection('users').doc(userId).set({
      'history': list,
    }, SetOptions(merge: true));
  }

  @override
  Future<List<int>> getHistory({required String userId}) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return List<int>.from(doc.data()?['history'] ?? []);
  }

  @override
  Future<void> clearHistory({required String userId}) async {
    await _firestore.collection('users').doc(userId).set({
      'history': [],
    }, SetOptions(merge: true));
  }
}
