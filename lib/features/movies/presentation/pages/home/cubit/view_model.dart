import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/core/usecases/no_pramas.dart';
import 'package:moives/features/movies/domain/usecases/movie_use_case.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/states.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({required this.getMovieUseCase}) : super(HomeLoading());
  GetMovieUseCase getMovieUseCase;

  Future<void> getMoviesList() async {
    emit(HomeLoading());
    final response = await getMovieUseCase(NoParams());
    response.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (movies) => emit(HomeSuccess(movie: movies.data?.movies ?? [])),
    );
  }
}
