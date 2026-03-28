
import '../../../domain/entities/user.dart';

abstract class LoginState{}

class LoginInit extends LoginState{}

class LoginLoading extends LoginState{}
class LoginFaceBookLoading extends LoginState{}
class LoginGoogleLoading extends LoginState{}

class LoginSuccess extends LoginState{
  final UserEntity user;
  LoginSuccess(this.user);
}

class LoginError extends LoginState{
  final String message ;
  LoginError(this.message);
}

class LogoutLoading extends LoginState {}
class LogoutSuccess extends LoginState {}
class LogoutError extends LoginState {
  final String message;
  LogoutError(this.message);
}