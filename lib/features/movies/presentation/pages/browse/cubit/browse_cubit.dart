import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/usecases/movie_params.dart';
import 'package:moives/features/movies/domain/usecases/movie_use_case.dart';
import 'package:moives/features/movies/presentation/pages/browse/cubit/browse_states.dart';

import '../../../../domain/entities/response/movie_list/movie.dart';

@singleton
class BrowseCubit extends Cubit<BrowseStates> {
  BrowseCubit({required this.useCase}) : super(LoadingBrowse());
  GetMovieUseCase useCase;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<Movie> _movies = [];
  String _selectedGenre = '';
  Map<String, List<Movie>> _genreMovies = {};

  bool get isLoadingMore => _isLoadingMore;

  Future<void> getMoviesByGenre(String genre, {bool isLoadMore = false}) async {
    if (genre != _selectedGenre) {
      _currentPage = 1;
      _hasMore = true;
      _movies = [];
      _selectedGenre = genre;
    }

    if (_genreMovies.containsKey(genre)) {
      emit(SuccessBrowse(movies: _genreMovies[genre]!, selectedGenre: genre));
      return;
    }
    if (_isLoadingMore || !_hasMore) return;

    if (isLoadMore) {
      _isLoadingMore = true;
    }

    final response = await useCase.call(
      MovieParams(genre: genre, page: _currentPage),
    );
    response.fold((failure) => emit(ErrorBrowse(message: failure.message)), (
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
      emit(SuccessBrowse(movies: _movies, selectedGenre: _selectedGenre));
    });
  }
}
