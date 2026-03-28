import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/auth/domain/repositories/auth_repository.dart';

import '../../entities/user.dart';

class LoginUseCase {
  final AuthRepository repository ;

  LoginUseCase(this.repository);

  Future<Either<Failures,UserEntity>> call(String email , String password){
    return repository.login(email, password);
  }

}