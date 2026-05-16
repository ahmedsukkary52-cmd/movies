import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/errors/exceptions.dart';
import 'package:moives/core/network/apiServices/api_services.dart';
import 'package:moives/features/movies/data/mappers/movie_list_mapper.dart';
import 'package:moives/features/movies/domain/datasource/remote/movies_remote_data_source.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movies_list.dart';

@Injectable(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  ApiServices apiServices;

  MoviesRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<MoviesList> getMoviesList({int page = 1, String? genre}) async {
    try {
      var movieListResponse = await apiServices.getMoviesList(
          page: page, genre: genre);
      return movieListResponse.toMovieList();
    } on DioException catch (e) {
      String message = (e.error as AppExceptions).message;
      throw ServerExceptions(message: message);
    }
  }
}
