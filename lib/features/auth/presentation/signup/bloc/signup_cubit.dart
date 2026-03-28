import 'package:dokan/features/auth/domain/usecases/signup/signup_usecase.dart';
import 'package:dokan/features/auth/presentation/signup/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState>{
  final SignupUseCase signupUseCase;

  SignupCubit(this.signupUseCase):super(SignUpInitState());

  Future<void> signup (String name ,String email , String password) async {

    emit(SignUpLoadingState());
    final result = await signupUseCase(name ,email, password);

    result.fold(
          (failure) => emit(SignUpErrorState(failure.massage)),
          (user) => emit(SignUpSuccessState(user)),
    );
  }

}