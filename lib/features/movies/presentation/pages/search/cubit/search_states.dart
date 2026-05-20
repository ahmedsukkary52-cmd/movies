import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

sealed class SearchStates {}

class SearchInitial extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchLoadingMore extends SearchStates {}

class SearchError extends SearchStates {
  final String message;

  SearchError({required this.message});
}

class SearchSuccess extends SearchStates {
  final List<Movie> movie;

  SearchSuccess({required this.movie});
}
