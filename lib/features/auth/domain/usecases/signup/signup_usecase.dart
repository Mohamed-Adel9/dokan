
import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/auth/domain/entities/user.dart';
import 'package:dokan/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository ;

  SignupUseCase(this.repository);

  Future<Either<Failures,UserEntity>> call
      (String name , String email , String password)
  {
    return  repository.signUp(name, email, password);
  }
}