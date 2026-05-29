import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/usecases/no_params.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class GoogleLoginUseCase extends BaseUseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.loginWithGoogle();
  }
}
