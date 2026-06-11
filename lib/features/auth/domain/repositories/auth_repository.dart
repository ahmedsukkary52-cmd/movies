import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  });

  Future<Either<Failure, UserEntity>> loginWithGoogle();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> forgotPassword({required String email});
}
