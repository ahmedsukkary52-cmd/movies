import 'package:dio/dio.dart';
import 'package:moives/features/movies/data/models/response/movie_details/movie_details_dto.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_list_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../utils/app_constants.dart';
import '../../utils/app_endpoint.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET(AppEndpoint.movieList)
  Future<MoviesListDto> getMoviesList({
    @Query(AppEndpoint.page) int page = 1,
    @Query(AppEndpoint.genre) String? genre,
  });

  @GET(AppEndpoint.movieDetails)
  Future<MovieDetailsDto> getMoviesDetails({
    @Query(AppEndpoint.movieId) int? movieId,
    @Query(AppEndpoint.withCast) bool withCast = true,
    @Query(AppEndpoint.withImage) bool withImages = true,
  });
}
