
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phone_bloc/repository/repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(
    this._authRepository,
  ) : super(LoginState.initial());

  void emailChange(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChange(String value) {

    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }
  Future<void> logInwithCredentials() async {

    if (state.status == LoginStatus.submitting) return;

     emit(state.copyWith(status: LoginStatus.submitting));

     try {
      await _authRepository.loginwithEmailandPassword(email: state.email, password: state.password);
       emit(state.copyWith(status: LoginStatus.success));
     } catch (_) {
       
     }
  }
}
