import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/forget_password/forget_password_usecase.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState>{


  final ForgetPasswordUseCase forgetPasswordUseCase ;

  ForgetPasswordCubit(this.forgetPasswordUseCase)
      : super(ForgetPasswordInit());

  Future<void> forgetPassword (String email ) async {

    emit(ForgetPasswordLoading());
    final result = await forgetPasswordUseCase(email);

    result.fold(
          (failure) => emit(ForgetPasswordError(failure.massage)),
          (_) => emit(ForgetPasswordSuccess()),
    );
  }



}