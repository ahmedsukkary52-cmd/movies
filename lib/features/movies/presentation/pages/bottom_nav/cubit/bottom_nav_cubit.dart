import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'bottom_nav_state.dart';

@injectable
class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavStates(currentIndex: 0));

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void selectGenre(String genre) {
    emit(state.copyWith(selectedGenre: genre));
  }
}
