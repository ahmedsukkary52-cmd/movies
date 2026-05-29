import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/auth_params.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase extends BaseUseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}
