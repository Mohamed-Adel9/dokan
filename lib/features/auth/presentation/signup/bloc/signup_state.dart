import 'package:dokan/features/auth/domain/entities/user.dart';

abstract class SignupState {}

class SignUpInitState extends SignupState {}
class SignUpLoadingState extends SignupState {}
class SignUpSuccessState extends SignupState {
  final UserEntity userEntity ;

  SignUpSuccessState(this.userEntity);
}
class SignUpErrorState extends SignupState {
  final String message ;
  SignUpErrorState(this.message);
}