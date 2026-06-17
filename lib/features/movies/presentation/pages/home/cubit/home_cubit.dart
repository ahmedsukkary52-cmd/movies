import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/usecases/movie_params.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';
import 'package:moives/features/movies/domain/usecases/movie_use_case.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/states.dart';

@singleton
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({required this.getMovieUseCase}) : super(HomeLoading());
  GetMovieUseCase getMovieUseCase;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<Movie> _movies = [];

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  void handlePagination(int index) {
    final state = this.state;
    if (state is! HomeSuccess) return;
    final shouldLoadMore =
        index >= state.movie.length - 3 && !state.isLoadingMore;
    if (shouldLoadMore) getMoviesList(isLoadMore: true);
  }

  Future<void> getMoviesList({bool isLoadMore = false}) async {
    if (_isLoadingMore || !_hasMore) return;

    if (!isLoadMore) {
      _currentPage = 1;
      _hasMore = true;
      _movies = [];
      emit(HomeLoading());
    } else {
      _isLoadingMore = true;
    }

    final response = await getMovieUseCase(MovieParams(page: _currentPage));

    response.fold(
      (failure) {
        _isLoadingMore = false;
        emit(HomeError(message: failure.message));
      },
      (moviesList) {
        final newMovies = moviesList.data?.movies ?? [];
        if (newMovies.isEmpty) {
          _hasMore = false;
        } else {
          _movies.addAll(newMovies);
          _currentPage++;
        }
        _isLoadingMore = false;
        emit(HomeSuccess(movie: _movies));
      },
    );
  }
}