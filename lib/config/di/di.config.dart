// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/network/apiServices/api_services.dart' as _i48;
import '../../core/network/dio/dio_client.dart' as _i765;
import '../../core/network/dio/dio_module.dart' as _i555;
import '../../features/auth/data/data_source/remote/auth_remote_data_source_impl.dart'
    as _i923;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/data_sources/remote/auth_remote_data_source.dart'
    as _i633;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/forget_password_usecase.dart'
    as _i948;
import '../../features/auth/domain/usecases/google_login_usecase.dart' as _i850;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/auth/cubit/auth_cubit.dart' as _i72;
import '../../features/auth/presentation/auth/profile/cubit/edit_profile_cubit/edit_profile_cubit.dart'
    as _i667;
import '../../features/auth/presentation/auth/profile/cubit/profile_cubit/profile_cubit.dart'
    as _i655;
import '../../features/movies/data/datasources/remote/history_remote_data_source_impl.dart'
    as _i108;
import '../../features/movies/data/datasources/remote/movies_remote_data_source_impl.dart'
    as _i587;
import '../../features/movies/data/datasources/remote/watch_list_remote_data_source_impl.dart'
    as _i1026;
import '../../features/movies/data/repositories/movies_repository_impl.dart'
    as _i985;
import '../../features/movies/data/repositories/watch_list_repository_impl.dart'
    as _i1000;
import '../../features/movies/domain/datasource/remote/history_remote_data_source.dart'
    as _i897;
import '../../features/movies/domain/datasource/remote/movies_remote_data_source.dart'
    as _i322;
import '../../features/movies/domain/datasource/remote/watch_list_remote_data_source.dart'
    as _i165;
import '../../features/movies/domain/repositories/movies_repository.dart'
    as _i435;
import '../../features/movies/domain/repositories/watch_list_repository.dart'
    as _i756;
import '../../features/movies/domain/usecases/add_to_history_usecase.dart'
    as _i665;
import '../../features/movies/domain/usecases/add_to_watch_list_usecase.dart'
    as _i1044;
import '../../features/movies/domain/usecases/get_history_usecase.dart'
    as _i967;
import '../../features/movies/domain/usecases/get_watch_list_usecase.dart'
    as _i36;
import '../../features/movies/domain/usecases/is_in_watch_list_usecase.dart'
    as _i351;
import '../../features/movies/domain/usecases/movie_details_use_case.dart'
    as _i376;
import '../../features/movies/domain/usecases/movie_suggestions_use_case.dart'
    as _i626;
import '../../features/movies/domain/usecases/movie_use_case.dart' as _i207;
import '../../features/movies/domain/usecases/remove_from_watch_list_usecase.dart'
    as _i60;
import '../../features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_cubit.dart'
    as _i175;
import '../../features/movies/presentation/pages/browse/cubit/browse_cubit.dart'
    as _i981;
import '../../features/movies/presentation/pages/home/cubit/genre_section_cubit/genre_sections_cubit.dart'
    as _i377;
import '../../features/movies/presentation/pages/home/cubit/home_cubit.dart'
    as _i483;
import '../../features/movies/presentation/pages/movie_details/cuibt/details_cubit.dart'
    as _i440;
import '../../features/movies/presentation/pages/search/cubit/search_cubit.dart'
    as _i999;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diModule = _$DiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => diModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i175.BottomNavCubit>(() => _i175.BottomNavCubit());
    gh.singleton<_i765.DioClient>(() => _i765.DioClient());
    gh.singleton<_i59.FirebaseAuth>(() => diModule.provideFirebaseAuth());
    gh.singleton<_i116.GoogleSignIn>(() => diModule.provideGoogleSignIn());
    gh.singleton<_i667.EditProfileCubit>(() => _i667.EditProfileCubit());
    gh.factory<_i897.HistoryRemoteDataSource>(
      () => _i108.HistoryRemoteDataSourceImpl(),
    );
    gh.singleton<_i361.Dio>(() => diModule.provideDio(gh<_i765.DioClient>()));
    gh.singleton<_i48.ApiServices>(
      () => diModule.provideApiServices(gh<_i361.Dio>()),
    );
    gh.factory<_i165.WatchlistRemoteDataSource>(
      () => _i1026.WatchlistRemoteDataSourceImpl(),
    );
    gh.factory<_i756.WatchlistRepository>(
      () => _i1000.WatchlistRepositoryImpl(
        watchlistDataSource: gh<_i165.WatchlistRemoteDataSource>(),
        historyDataSource: gh<_i897.HistoryRemoteDataSource>(),
      ),
    );
    gh.factory<_i633.AuthRemoteDataSource>(
      () => _i923.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.factory<_i665.AddToHistoryUseCase>(
      () => _i665.AddToHistoryUseCase(gh<_i756.WatchlistRepository>()),
    );
    gh.factory<_i1044.AddToWatchlistUseCase>(
      () => _i1044.AddToWatchlistUseCase(gh<_i756.WatchlistRepository>()),
    );
    gh.factory<_i967.GetHistoryUseCase>(
      () => _i967.GetHistoryUseCase(gh<_i756.WatchlistRepository>()),
    );
    gh.factory<_i36.GetWatchlistUseCase>(
      () => _i36.GetWatchlistUseCase(gh<_i756.WatchlistRepository>()),
    );
    gh.factory<_i351.IsInWatchlistUseCase>(
      () => _i351.IsInWatchlistUseCase(gh<_i756.WatchlistRepository>()),
    );
    gh.factory<_i60.RemoveFromWatchlistUseCase>(
      () => _i60.RemoveFromWatchlistUseCase(gh<_i756.WatchlistRepository>()),
    );
    gh.factory<_i322.MoviesRemoteDataSource>(
      () =>
          _i587.MoviesRemoteDataSourceImpl(apiServices: gh<_i48.ApiServices>()),
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        remoteDataSource: gh<_i633.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i435.MoviesRepository>(
      () => _i985.MoviesRepositoryImpl(
        remoteDataSource: gh<_i322.MoviesRemoteDataSource>(),
      ),
    );
    gh.factory<_i948.ForgetPasswordUseCase>(
      () => _i948.ForgetPasswordUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i850.GoogleLoginUseCase>(
      () => _i850.GoogleLoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i376.MovieDetailsUseCase>(
      () => _i376.MovieDetailsUseCase(repository: gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i626.MovieSuggestionsUseCase>(
      () => _i626.MovieSuggestionsUseCase(
        repository: gh<_i435.MoviesRepository>(),
      ),
    );
    gh.factory<_i207.GetMovieUseCase>(
      () => _i207.GetMovieUseCase(gh<_i435.MoviesRepository>()),
    );
    gh.factory<_i440.DetailsCubit>(
      () => _i440.DetailsCubit(
        useCase: gh<_i376.MovieDetailsUseCase>(),
        suggestionsUseCase: gh<_i626.MovieSuggestionsUseCase>(),
      ),
    );
    gh.factory<_i72.AuthCubit>(
      () => _i72.AuthCubit(
        loginUseCase: gh<_i188.LoginUseCase>(),
        googleLoginUseCase: gh<_i850.GoogleLoginUseCase>(),
        registerUseCase: gh<_i941.RegisterUseCase>(),
        forgetPasswordUseCase: gh<_i948.ForgetPasswordUseCase>(),
        logoutUseCase: gh<_i48.LogoutUseCase>(),
      ),
    );
    gh.singleton<_i981.BrowseCubit>(
      () => _i981.BrowseCubit(useCase: gh<_i207.GetMovieUseCase>()),
    );
    gh.factory<_i999.SearchCubit>(
      () => _i999.SearchCubit(useCase: gh<_i207.GetMovieUseCase>()),
    );
    gh.singleton<_i655.ProfileCubit>(
      () => _i655.ProfileCubit(
        getWatchlistUseCase: gh<_i36.GetWatchlistUseCase>(),
        getHistoryUseCase: gh<_i967.GetHistoryUseCase>(),
        addToWatchlistUseCase: gh<_i1044.AddToWatchlistUseCase>(),
        removeFromWatchlistUseCase: gh<_i60.RemoveFromWatchlistUseCase>(),
        isInWatchlistUseCase: gh<_i351.IsInWatchlistUseCase>(),
        addToHistoryUseCase: gh<_i665.AddToHistoryUseCase>(),
        movieDetailsUseCase: gh<_i376.MovieDetailsUseCase>(),
      ),
    );
    gh.singleton<_i377.GenreSectionsCubit>(
      () => _i377.GenreSectionsCubit(
        getMovieUseCase: gh<_i207.GetMovieUseCase>(),
      ),
    );
    gh.singleton<_i483.HomeCubit>(
      () => _i483.HomeCubit(getMovieUseCase: gh<_i207.GetMovieUseCase>()),
    );
    return this;
  }
}

class _$DiModule extends _i555.DiModule {}
