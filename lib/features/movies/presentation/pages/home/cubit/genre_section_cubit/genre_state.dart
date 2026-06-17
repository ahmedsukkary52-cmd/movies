import '../../../../../domain/entities/response/movie_list/movie.dart';

sealed class GenreSectionsStates {}

class GenreSectionsLoading extends GenreSectionsStates {}

class GenreSectionsSuccess extends GenreSectionsStates {
  final Map<String, List<Movie>> moviesByGenre;

  GenreSectionsSuccess({required this.moviesByGenre});
}

class GenreSectionsError extends GenreSectionsStates {
  final String message;

  GenreSectionsError({required this.message});
}
