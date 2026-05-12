// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/network/apiServices/api_services.dart' as _i247;
import '../core/network/dio/dio_client.dart' as _i980;
import '../features/movies/data/datasources/remote/movies_remote_data_source_impl.dart'
    as _i801;
import '../features/movies/data/repositories/movies_repository_impl.dart'
    as _i63;
import '../features/movies/domain/datasource/remote/movies_remote_data_source.dart'
    as _i134;
import '../features/movies/domain/repositories/movies_repository.dart' as _i393;
import '../features/movies/domain/usecases/movie_use_case.dart' as _i609;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i980.DioClient>(() => _i980.DioClient());
    gh.factory<_i247.ApiServices>(
      () => _i247.ApiServices(gh<_i361.Dio>(), baseUrl: gh<String>()),
    );
    gh.factory<_i134.MoviesRemoteDataSource>(
      () => _i801.MoviesRemoteDataSourceImpl(
        apiServices: gh<_i247.ApiServices>(),
      ),
    );
    gh.factory<_i393.MoviesRepository>(
      () => _i63.MoviesRepositoryImpl(
        remoteDataSource: gh<_i134.MoviesRemoteDataSource>(),
      ),
    );
    gh.factory<_i609.GetMovieUseCase>(
      () => _i609.GetMovieUseCase(gh<_i393.MoviesRepository>()),
    );
    return this;
  }
}
