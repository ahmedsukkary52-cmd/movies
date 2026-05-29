import '../../entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login({required String email, required String password});

  Future<UserEntity> loginWithGoogle();

  Future<void> logout();

  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  });

  Future<void> forgotPassword({required String email});
}
