import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/movies/domain/usecases/movie_details_use_case.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/cuibt/details_states.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class DetailsCubit extends Cubit<DetailsStates> {
  DetailsCubit({required this.useCase}) : super(DetailsLoading());
  MovieDetailsUseCase useCase;

  Future<void> getMovieDetails({required int movieId}) async {
    emit(DetailsLoading());
    var response = await useCase.call(movieId);
    response.fold((failure) => emit(DetailsError(message: failure.message)), (
      movieDetails,
    ) {
      final movie = movieDetails.data?.movie;
      final screenShots = [
        if (movie?.largeScreenshotImage1 != null) movie!.largeScreenshotImage1!,
        if (movie?.largeScreenshotImage2 != null) movie!.largeScreenshotImage2!,
        if (movie?.largeScreenshotImage3 != null) movie!.largeScreenshotImage3!,
      ];
      emit(
        DetailsSuccess(
          movieDetailsData: movieDetails.data,
          screenShots: screenShots,
        ),
      );
    });
  }

  Future<void> watchMovie(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}
