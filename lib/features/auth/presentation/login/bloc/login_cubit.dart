import 'package:dokan/features/auth/domain/usecases/login/login_facebook_usecase.dart';
import 'package:dokan/features/auth/domain/usecases/logout/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login/login_google_usecase.dart';
import '../../../domain/usecases/login/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{

  final LoginGoogleUseCase loginGoogleUseCase ;
  final LoginFacebookUseCase loginFacebookUseCase ;
  final LoginUseCase loginUseCase ;
  final LogoutUseCase logoutUseCase ;

  LoginCubit(this.loginGoogleUseCase,
      this.loginUseCase,
      this.loginFacebookUseCase,
      this.logoutUseCase)
      : super(LoginInit());

  Future<void> login (String email , String password) async {

    emit(LoginLoading());
    final result = await loginUseCase(email, password);

    result.fold(
          (failure) => emit(LoginError(failure.massage)),
          (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginGoogleLoading());

    final result = await loginGoogleUseCase();

    result.fold(
          (failure) => emit(LoginError(failure.massage)),
          (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(LoginFaceBookLoading());

    final result = await loginFacebookUseCase();

    result.fold(
      (failure) => emit(LoginError(failure.massage)),
        (user) => emit(LoginSuccess(user))
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await logoutUseCase.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }


}