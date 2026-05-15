import 'package:dartz/dartz.dart';
import 'package:moives/core/errors/failure.dart';

abstract class BaseUseCase<OutPut, InPut> {
  Future<Either<Failure, OutPut>> call(InPut params);
}
