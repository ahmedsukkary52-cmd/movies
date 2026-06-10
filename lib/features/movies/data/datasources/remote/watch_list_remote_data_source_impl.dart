import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/datasource/remote/watch_list_remote_data_source.dart';

@Injectable(as: WatchlistRemoteDataSource)
class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addToWatchlist({
    required String userId,
    required int movieId,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'watchlist': FieldValue.arrayUnion([movieId]),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> removeFromWatchlist({
    required String userId,
    required int movieId,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'watchlist': FieldValue.arrayRemove([movieId]),
    }, SetOptions(merge: true));
  }

  @override
  Future<List<int>> getWatchlist({required String userId}) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    final list = List<int>.from(doc.data()?['watchlist'] ?? []);
    return list.reversed.toList();
  }

  @override
  Future<bool> isInWatchlist({
    required String userId,
    required int movieId,
  }) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    final list = List<int>.from(doc.data()?['watchlist'] ?? []);
    return list.contains(movieId);
  }
}
