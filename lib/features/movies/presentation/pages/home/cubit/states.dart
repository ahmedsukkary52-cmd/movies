import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

sealed class HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  List<Movie> movie;

  HomeSuccess({required this.movie});
}

class HomeError extends HomeStates {
  String message;

  HomeError({required this.message});
}
