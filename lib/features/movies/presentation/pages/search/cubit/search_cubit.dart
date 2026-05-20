import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/movies/domain/usecases/movie_use_case.dart';
import 'package:moives/features/movies/presentation/pages/search/cubit/search_states.dart';

import '../../../../../../core/usecases/movie_params.dart';
import '../../../../domain/entities/response/movie_list/movie.dart';

@injectable
class SearchCubit extends Cubit<SearchStates> {
  SearchCubit({required this.useCase}) : super(SearchInitial());
  GetMovieUseCase useCase;
  Timer? _debounce;
  List<Movie> _currentMovies = [];

  List<Movie> get currentMovies => _currentMovies;

  Future<void> getInitialMovie() async {
    emit(SearchLoading());
    final response = await useCase.call(MovieParams(page: 1));
    response.fold((failure) => emit(SearchError(message: failure.message)), (
      moviesList,
    ) {
      _currentMovies = moviesList.data?.movies ?? [];
      emit(SearchSuccess(movie: _currentMovies));
    });
  }

  Future<void> searchImmediate(String query) async {
    _debounce?.cancel();
    emit(SearchLoading());
    final response = await useCase.call(MovieParams(query: query));
    response.fold(
      (failure) => emit(SearchError(message: failure.message)),
      (moviesList) => emit(SearchSuccess(movie: moviesList.data?.movies ?? [])),
    );
  }

  Future<void> search(String query) async {
    emit(SearchLoadingMore());
    final response = await useCase.call(MovieParams(query: query));
    response.fold((failure) => emit(SearchError(message: failure.message)), (
      moviesList,
    ) {
      _currentMovies = moviesList.data?.movies ?? [];
      emit(SearchSuccess(movie: _currentMovies));
    });
  }
}
