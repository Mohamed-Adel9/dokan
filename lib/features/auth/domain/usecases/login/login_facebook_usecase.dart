import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/auth/domain/repositories/auth_repository.dart';
import '../../entities/user.dart';

class LoginFacebookUseCase {
  final AuthRepository repository ;

  LoginFacebookUseCase(this.repository);

  Future<Either<Failures,UserEntity>> call(){
    return repository.loginWithFacebook();
  }

}