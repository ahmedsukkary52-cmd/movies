import '../../../../../../movies/domain/entities/response/movie_list/movie.dart';
import '../../../../../domain/entities/user.dart';

sealed class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileSuccess extends ProfileStates {
  final UserEntity user;
  final List<Movie> watchlist;
  final List<Movie> history;
  final int watchlistCount;
  final int historyCount;
  final String? phone;
  final bool isLoadingLists;

  ProfileSuccess({
    required this.user,
    required this.watchlist,
    required this.history,
    required this.watchlistCount,
    required this.historyCount,
    required this.phone,
    this.isLoadingLists = false,
  });
}

class ProfileError extends ProfileStates {
  final String message;

  ProfileError({required this.message});
}

class WatchlistUpdated extends ProfileStates {
  final bool isInWatchlist;

  WatchlistUpdated({required this.isInWatchlist});
}
