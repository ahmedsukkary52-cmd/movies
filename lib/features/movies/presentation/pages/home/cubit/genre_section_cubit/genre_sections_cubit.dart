import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/usecases/movie_params.dart';
import '../../../../../domain/entities/response/movie_list/movie.dart';
import '../../../../../domain/usecases/movie_use_case.dart';
import 'genre_state.dart';

@singleton
class GenreSectionsCubit extends Cubit<GenreSectionsStates> {
  GenreSectionsCubit({required this.getMovieUseCase})
    : super(GenreSectionsLoading());
  final GetMovieUseCase getMovieUseCase;

  final List<String> _genres = [
    'Action',
    'Comedy',
    'Horror',
    'Drama',
    'Romance',
  ];

  Future<void> getMoviesByGenre() async {
    emit(GenreSectionsLoading());
    final shuffled = List.of(_genres)..shuffle();
    final selected = shuffled.take(3).toList();
    final Map<String, List<Movie>> moviesByGenre = {};

    for (var genre in selected) {
      final response = await getMovieUseCase(MovieParams(genre: genre));
      response.fold((failure) => null, (moviesList) {
        moviesByGenre[genre] = moviesList.data?.movies ?? [];
      });
    }

    emit(GenreSectionsSuccess(moviesByGenre: moviesByGenre));
  }
}
