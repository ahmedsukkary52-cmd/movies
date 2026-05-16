import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

sealed class HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<Movie> movie;
  final bool isLoadingMore;
  final bool isLoadingGenre;
  final Map<String, List<Movie>> moviesByGenre;

  HomeSuccess({
    required this.movie,
    this.isLoadingMore = false,
    this.moviesByGenre = const {},
    this.isLoadingGenre = false
  });
}

class HomeError extends HomeStates {
  String message;

  HomeError({required this.message});
}
