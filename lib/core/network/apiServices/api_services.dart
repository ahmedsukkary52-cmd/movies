import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/movies/data/models/response/movie_list/movies_list_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../utils/app_constants.dart';
import '../../utils/app_endpoint.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET(AppEndpoint.movieList)
  Future<MoviesListDto> getMoviesList({@Query('page') int page = 1});
}
