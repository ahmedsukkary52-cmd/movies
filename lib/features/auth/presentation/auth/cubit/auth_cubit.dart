import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moives/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:moives/features/auth/domain/usecases/logout_usecase.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/usecases/auth_params.dart';
import '../../../../../core/usecases/no_params.dart';
import '../../../domain/usecases/google_login_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../profile/cubit/profile_cubit/profile_cubit.dart';
import 'auth_states.dart';

@injectable
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit({
    required this.loginUseCase,
    required this.googleLoginUseCase,
    required this.registerUseCase,
    required this.forgetPasswordUseCase,
    required this.logoutUseCase
  }) : super(AuthInitial());

  final LoginUseCase loginUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final LogoutUseCase logoutUseCase;

  Future<void> logout() async {
    emit(AuthLoading());
    final response = await logoutUseCase(NoParams());
    response.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (_) {
        getIt<ProfileCubit>().reset();
        emit(AuthInitial());
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final response = await loginUseCase(
        LoginParams(email: email, password: password));
    response.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (user) {
        getIt<ProfileCubit>().reset();
        emit(AuthSuccess(user: user));
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    final response = await googleLoginUseCase(NoParams());
    response.fold(
          (failure) => emit(AuthError(message: failure.message)),
          (user) {
        getIt<ProfileCubit>().reset();
        emit(AuthSuccess(user: user));
      },
    );
  }
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(AuthLoading());
    final response = await registerUseCase(
      RegisterParams(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatar: avatar,
      ),
    );
    response.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    final response = await forgetPasswordUseCase(email);
    response.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(AuthForgotPasswordSuccess()),
    );
  }
}
