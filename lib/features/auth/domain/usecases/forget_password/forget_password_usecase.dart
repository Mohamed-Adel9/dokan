import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';

import '../../repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<Either<Failures, void>> call(String email) async {
    return await repository.forgetPassword(email);
  }
}