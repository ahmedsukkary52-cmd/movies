import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/auth/presentation/auth/profile/cubit/profile_states.dart';

import '../../../../../../core/usecases/movie_params.dart';
import '../../../../../../core/usecases/no_params.dart';
import '../../../../../movies/domain/entities/response/movie_list/movie.dart';
import '../../../../../movies/domain/usecases/add_to_history_usecase.dart';
import '../../../../../movies/domain/usecases/add_to_watch_list_usecase.dart';
import '../../../../../movies/domain/usecases/get_history_usecase.dart';
import '../../../../../movies/domain/usecases/get_watch_list_usecase.dart';
import '../../../../../movies/domain/usecases/is_in_watch_list_usecase.dart';
import '../../../../../movies/domain/usecases/movie_use_case.dart';
import '../../../../../movies/domain/usecases/remove_from_watch_list_usecase.dart';
import '../../../../domain/entities/user.dart';

@injectable
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit({
    required this.getWatchlistUseCase,
    required this.getHistoryUseCase,
    required this.addToWatchlistUseCase,
    required this.removeFromWatchlistUseCase,
    required this.isInWatchlistUseCase,
    required this.addToHistoryUseCase,
    required this.getMovieUseCase,
  }) : super(ProfileInitial());

  final GetWatchlistUseCase getWatchlistUseCase;
  final GetHistoryUseCase getHistoryUseCase;
  final AddToWatchlistUseCase addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase removeFromWatchlistUseCase;
  final IsInWatchlistUseCase isInWatchlistUseCase;
  final AddToHistoryUseCase addToHistoryUseCase;
  final GetMovieUseCase getMovieUseCase;

  Future<void> getProfile(UserEntity user) async {
    emit(ProfileLoading());
    final watchlistIds = await getWatchlistUseCase(NoParams());
    final historyIds = await getHistoryUseCase(NoParams());

    List<Movie> watchlistMovies = [];
    List<Movie> historyMovies = [];

    await watchlistIds.fold((failure) => null, (ids) async {
      for (var id in ids) {
        final response = await getMovieUseCase(MovieParams(movieId: id));
        response.fold((failure) => null, (moviesList) {
          if (moviesList.data?.movies?.isNotEmpty ?? false) {
            watchlistMovies.add(moviesList.data!.movies!.first);
          }
        });
      }
    });

    await historyIds.fold((failure) => null, (ids) async {
      for (var id in ids) {
        final response = await getMovieUseCase(MovieParams(movieId: id));
        response.fold((failure) => null, (moviesList) {
          if (moviesList.data?.movies?.isNotEmpty ?? false) {
            historyMovies.add(moviesList.data!.movies!.first);
          }
        });
      }
    });

    emit(
      ProfileSuccess(
        user: user,
        watchlist: watchlistMovies,
        history: historyMovies,
        watchlistCount: watchlistMovies.length,
        historyCount: historyMovies.length,
      ),
    );
  }

  Future<void> toggleWatchlist(int movieId) async {
    final isIn = await isInWatchlistUseCase(movieId);
    isIn.fold((failure) => null, (isInWatchlist) async {
      if (isInWatchlist) {
        await removeFromWatchlistUseCase(movieId);
      } else {
        await addToWatchlistUseCase(movieId);
      }
      emit(WatchlistUpdated(isInWatchlist: !isInWatchlist));
    });
  }

  Future<void> addToHistory(int movieId) async {
    await addToHistoryUseCase(movieId);
  }
}
