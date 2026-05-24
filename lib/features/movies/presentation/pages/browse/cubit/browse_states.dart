import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

sealed class BrowseStates {}

class LoadingBrowse extends BrowseStates {}

class ErrorBrowse extends BrowseStates {
  final String message;

  ErrorBrowse({required this.message});
}

class SuccessBrowse extends BrowseStates {
  final List<Movie> movies;
  final String selectedGenre;

  SuccessBrowse({required this.movies, required this.selectedGenre});
}
