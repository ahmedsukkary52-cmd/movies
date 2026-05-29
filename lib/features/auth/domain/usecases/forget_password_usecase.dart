import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/auth_repository.dart';

@injectable
class ForgetPasswordUseCase extends BaseUseCase<void, String> {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) {
    return repository.forgotPassword(email: params);
  }
}
