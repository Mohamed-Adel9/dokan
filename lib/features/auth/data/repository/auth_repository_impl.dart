import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/exceptions.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:dokan/features/auth/domain/entities/user.dart';
import 'package:dokan/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' hide FirebaseAuthException;

class AuthRepositoryImpl implements  AuthRepository{

  final AuthRemoteDataSource remote ;

  AuthRepositoryImpl(this.remote);

  // login
  @override
  Future<Either<Failures, UserEntity>> login(String email, String password)async {

    try{
      final user = await remote.login(email, password);
      return Right(user);

    }on AuthException{
      return Left(AuthFailure("Invalid credentials"));
    }on NetworkException {
      return  Left(NetworkFailure("No internet connection"));

    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message));

    }on ServerException {
      return Left(ServerFailure("Server error"));

    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }

  }

  @override
  Future<Either<Failures, UserEntity>> loginWithGoogle() async {
    try {
      final user = await remote.loginGoogle();
      return Right(user);
    } on AuthException{
      return Left(AuthFailure("Invalid credentials"));
    }on NetworkException {
      return  Left(NetworkFailure("No internet connection"));

    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message));

    }on ServerException {
      return Left(ServerFailure("Server error"));

    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> loginWithFacebook() async {
    try{
      final user = await remote.loginFacebook();
      return Right(user);
    }on AuthException{
      return Left(AuthFailure("Invalid credentials"));
    }on NetworkException {
      return  Left(NetworkFailure("No internet connection"));

    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message));

    }on ServerException {
      return Left(ServerFailure("Server error"));

    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }


  //logout
  @override
  Future<void> logout() async {
    await remote.logout();
  }


  //signup
  @override
  Future<Either<Failures, UserEntity>> signUp
      (String name, String email, String password) async
  {
    try {
      final user = await remote.signUp(name, email, password);
      return Right(user);
    } on AuthException{
      return Left(AuthFailure("Invalid credentials"));
    }on NetworkException {
      return  Left(NetworkFailure("No internet connection"));

    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message));

    }on ServerException {
      return Left(ServerFailure("Server error"));

    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failures, void>> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.setLanguageCode('en');
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(null);

    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(_mapFirebaseError(e.toString())));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Invalid email address format';
      case 'user-not-found':      // ✅ Firebase throws this if email not registered
        return 'No account found with this email';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'network-request-failed':
        return 'No internet connection';
      default:
        return 'Something went wrong. Please try again';
    }
  }
}