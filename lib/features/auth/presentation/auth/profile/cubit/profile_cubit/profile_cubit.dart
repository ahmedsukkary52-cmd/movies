import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/auth/presentation/auth/profile/cubit/profile_cubit/profile_states.dart';

import '../../../../../../../core/usecases/watch_list_params.dart';
import '../../../../../../movies/domain/entities/response/movie_list/movie.dart';
import '../../../../../../movies/domain/usecases/add_to_history_usecase.dart';
import '../../../../../../movies/domain/usecases/add_to_watch_list_usecase.dart';
import '../../../../../../movies/domain/usecases/get_history_usecase.dart';
import '../../../../../../movies/domain/usecases/get_watch_list_usecase.dart';
import '../../../../../../movies/domain/usecases/is_in_watch_list_usecase.dart';
import '../../../../../../movies/domain/usecases/movie_details_use_case.dart';
import '../../../../../../movies/domain/usecases/remove_from_watch_list_usecase.dart';
import '../../../../../domain/entities/user.dart';

@singleton
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit({
    required this.getWatchlistUseCase,
    required this.getHistoryUseCase,
    required this.addToWatchlistUseCase,
    required this.removeFromWatchlistUseCase,
    required this.isInWatchlistUseCase,
    required this.addToHistoryUseCase,
    required this.movieDetailsUseCase,
  }) : super(ProfileInitial());

  final GetWatchlistUseCase getWatchlistUseCase;
  final GetHistoryUseCase getHistoryUseCase;
  final AddToWatchlistUseCase addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase removeFromWatchlistUseCase;
  final IsInWatchlistUseCase isInWatchlistUseCase;
  final AddToHistoryUseCase addToHistoryUseCase;
  final MovieDetailsUseCase movieDetailsUseCase;
  UserEntity? _currentUser;

  UserEntity? get currentUser => _currentUser;


  void reset() {
    _currentUser = null;
    emit(ProfileInitial());
  }

  Future<void> getProfile(UserEntity user, {bool forceRefresh = false}) async {
    if (state is ProfileSuccess && !forceRefresh) return;
    _currentUser = user;

    emit(ProfileSuccess(
      user: user,
      watchlist: state is ProfileSuccess
          ? (state as ProfileSuccess).watchlist
          : [],
      history: state is ProfileSuccess ? (state as ProfileSuccess).history : [],
      watchlistCount: state is ProfileSuccess ? (state as ProfileSuccess)
          .watchlistCount : 0,
      historyCount: state is ProfileSuccess ? (state as ProfileSuccess)
          .historyCount : 0,
      phone: user.phone,
      isLoadingLists: true,
    ));

    final watchlistIds = await getWatchlistUseCase(
        UserIdParams(userId: user.id));
    final historyIds = await getHistoryUseCase(UserIdParams(userId: user.id));

    List<Movie> watchlistMovies = [];
    List<Movie> historyMovies = [];

    await watchlistIds.fold((failure) => null, (ids) async {
      for (var id in ids) {
        final response = await movieDetailsUseCase(id);
        response.fold((failure) => null, (movieDetails) {
          if (movieDetails.data?.movie != null) {
            final movie = movieDetails.data!.movie!;
            watchlistMovies.add(Movie(
              id: movie.id,
              title: movie.title,
              mediumCoverImage: movie.mediumCoverImage,
              rating: movie.rating?.toDouble(),
            ));
          }
        });
      }
    });

    await historyIds.fold((failure) => null, (ids) async {
      for (var id in ids) {
        final response = await movieDetailsUseCase(id);
        response.fold((failure) => null, (movieDetails) {
          if (movieDetails.data?.movie != null) {
            final movie = movieDetails.data!.movie!;
            historyMovies.add(Movie(
              id: movie.id,
              title: movie.title,
              mediumCoverImage: movie.mediumCoverImage,
              rating: movie.rating?.toDouble(),
            ));
          }
        });
      }
    });

    emit(ProfileSuccess(
      user: user,
      watchlist: watchlistMovies,
      history: historyMovies,
      watchlistCount: watchlistMovies.length,
      historyCount: historyMovies.length,
      phone: user.phone,
        isLoadingLists: false
    ));
  }
  Future<void> toggleWatchlist(int movieId) async {
    if (_currentUser == null) return;
    final currentState = state is ProfileSuccess
        ? state as ProfileSuccess
        : null;

    final isIn = await isInWatchlistUseCase(
      WatchlistParams(userId: _currentUser!.id, movieId: movieId),
    );

    isIn.fold((failure) => null, (isInWatchlist) async {
      if (isInWatchlist) {
        await removeFromWatchlistUseCase(
          WatchlistParams(userId: _currentUser!.id, movieId: movieId),
        );
        if (currentState != null) {
          final newWatchlist = currentState.watchlist
              .where((m) => m.id != movieId)
              .toList();
          emit(ProfileSuccess(
            user: currentState.user,
            watchlist: newWatchlist,
            history: currentState.history,
            watchlistCount: newWatchlist.length,
            historyCount: currentState.historyCount,
            phone: currentState.phone,
          ));
        }
      } else {
        await addToWatchlistUseCase(
          WatchlistParams(userId: _currentUser!.id, movieId: movieId),
        );
      }
    });
  }

  Future<void> addToHistory(int movieId) async {
    if (_currentUser == null) return;
    await addToHistoryUseCase(
      WatchlistParams(userId: _currentUser!.id, movieId: movieId),
    );
  }
}