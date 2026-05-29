import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/data_sources/remote/auth_remote_data_source.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final user = await remoteDataSource.loginWithGoogle();
      return Right(user);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await remoteDataSource.forgotPassword(email: email);
      return Right(null);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return Right(null);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    try {
      final user = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatar: avatar,
      );
      return Right(user);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkExceptions catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}
