import '../../../../domain/entities/response/movie_details/movie_details_data.dart';

sealed class DetailsStates {}

class DetailsLoading extends DetailsStates {}

class DetailsSuccess extends DetailsStates {
  final MovieDetailsData? movieDetailsData;
  final List<String> screenShots;

  DetailsSuccess({required this.movieDetailsData, required this.screenShots});
}

class DetailsError extends DetailsStates {
  String message;

  DetailsError({required this.message});
}
