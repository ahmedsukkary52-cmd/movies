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

import '../../core/network/apiServices/api_services.dart' as _i48;
import '../../core/network/dio/dio_client.dart' as _i765;
import '../../core/network/dio/dio_module.dart' as _i555;
import '../../features/movies/data/datasources/remote/movies_remote_data_source_impl.dart'
    as _i587;
import '../../features/movies/data/repositories/movies_repository_impl.dart'
    as _i985;
import '../../features/movies/domain/datasource/remote/movies_remote_data_source.dart'
    as _i322;
import '../../features/movies/domain/repositories/movies_repository.dart'
    as _i435;
import '../../features/movies/domain/usecases/movie_details_use_case.dart'
    as _i376;
import '../../features/movies/domain/usecases/movie_use_case.dart' as _i207;
import '../../features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_cubit.dart'
    as _i175;
import '../../features/movies/presentation/pages/home/cubit/view_model.dart'
    as _i483;
import '../../features/movies/presentation/pages/movie_details/cuibt/details_cubit.dart'
    as _i440;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    gh.factory<_i175.BottomNavCubit>(() => _i175.BottomNavCubit());
    gh.singleton<_i765.DioClient>(() => _i765.DioClient());
    gh.singleton<_i361.Dio>(() => diModule.provideDio(gh<_i765.DioClient>()));
    gh.singleton<_i48.ApiServices>(
      () => diModule.provideApiServices(gh<_i361.Dio>()),
    );
    gh.factory<_i322.MoviesRemoteDataSource>(
      () =>
          _i587.MoviesRemoteDataSourceImpl(apiServices: gh<_i48.ApiServices>()),
    );
    gh.factory<_i435.MoviesRepository>(
      () => _i985.MoviesRepositoryImpl(
        remoteDataSource: gh<_i322.MoviesRemoteDataSource>(),
      ),
    );
    gh.factory<_i376.MovieDetailsUseCase>(
      () => _i376.MovieDetailsUseCase(repository: gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i207.GetMovieUseCase>(
      () => _i207.GetMovieUseCase(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i440.DetailsCubit>(
      () => _i440.DetailsCubit(useCase: gh<_i376.MovieDetailsUseCase>()),
    );
    gh.singleton<_i483.HomeCubit>(
      () => _i483.HomeCubit(getMovieUseCase: gh<_i207.GetMovieUseCase>()),
    );
    return this;
  }
}

class _$DiModule extends _i555.DiModule {}
