import 'package:dokan/core/errors/failures.dart';

import '../entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserEntity>> login(String email, String password);
  Future<Either<Failures, UserEntity>> signUp(String name,String email, String password);
  Future<Either<Failures, void>> forgetPassword(String email);
  Future<Either<Failures, UserEntity>> loginWithGoogle();
  Future<Either<Failures, UserEntity>> loginWithFacebook();
  Future<void> logout () ;
}
