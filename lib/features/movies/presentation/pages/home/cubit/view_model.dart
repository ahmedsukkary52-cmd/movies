import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';
import 'package:moives/features/movies/domain/usecases/movie_use_case.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/states.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({required this.getMovieUseCase}) : super(HomeLoading());
  GetMovieUseCase getMovieUseCase;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<Movie> _movies = [];

  Future<void> getMoviesList({bool isLoadMore = false}) async {
    if (_isLoadingMore || !_hasMore) return; // ← منع الـ duplicate calls

    if (!isLoadMore) {
      emit(HomeLoading());
    } else {
      _isLoadingMore = true;
    }

    final response = await getMovieUseCase(_currentPage);

    response.fold((failure) => emit(HomeError(message: failure.message)), (
      moviesList,
    ) {
      final newMovies = moviesList.data?.movies ?? [];
      if (newMovies.isEmpty) {
        _hasMore = false;
      } else {
        _movies.addAll(newMovies);
        _currentPage++;
      }
      _isLoadingMore = false;
      emit(HomeSuccess(movie: _movies));
    });
  }
}
