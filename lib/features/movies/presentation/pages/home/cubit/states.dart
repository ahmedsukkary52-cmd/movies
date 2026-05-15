import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

sealed class HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final List<Movie> movie;
  final bool isLoadingMore;

  HomeSuccess({required this.movie, this.isLoadingMore = false});
}

class HomeError extends HomeStates {
  String message;

  HomeError({required this.message});
}
