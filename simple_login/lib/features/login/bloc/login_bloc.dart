import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login/features/login/bloc/login_event.dart';
import 'package:simple_login/features/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(
          const LoginState(
              email: '',
              password: '',
              isEmailValid: false,
              isPasswordValid: false,
              textEmailValid: null,
              textPassValid: null,
              loginStatus: LoginStatus.idle),
        ) {
    on<EmailChanged>(onEmailChanged);
    on<PasswordChanged>(onPasswordChanged);
    on<SubmitLogin>(onSubmitLogin);
  }

  void onEmailChanged(
    EmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = event.email;
    final emailValid = validEmail(event.email);

    emit(
      state.copyWith(
        email: email,
        isEmailValid: emailValid == null,
        textEmailValid: emailValid,
        isPasswordValid: state.isPasswordValid,
        password: state.password,
        textPassValid: state.textPassValid,
        loginStatus: state.loginStatus,
      ),
    );
  }

  void onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final pass = event.password;
    final passValid = validPass(pass);
    emit(
      state.copyWith(
        password: pass,
        isPasswordValid: passValid == null,
        textPassValid: passValid,
        email: state.email,
        isEmailValid: state.isEmailValid,
        textEmailValid: state.textEmailValid,
        loginStatus: state.loginStatus,
      ),
    );
  }

  Future<void> onSubmitLogin(
    SubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        password: state.password,
        isPasswordValid: state.isPasswordValid,
        textPassValid: state.textPassValid,
        email: state.email,
        isEmailValid: state.isEmailValid,
        textEmailValid: state.textEmailValid,
        loginStatus: LoginStatus.loading,
      ),
    );
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    emit(
      state.copyWith(
        password: state.password,
        isPasswordValid: state.isPasswordValid,
        textPassValid: state.textPassValid,
        email: state.email,
        isEmailValid: state.isEmailValid,
        textEmailValid: state.textEmailValid,
        loginStatus: LoginStatus.success,
      ),
    );
  }

  String? validEmail(String text) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(text)) {
      return 'Email inválido';
    }
    return null;
  }

  String? validPass(String text) {
    if (text.length < 8) {
      return 'Senha deve ter mais que 8 dígitos';
    }
    final containsLetter = text.contains(RegExp(r'[a-zA-Z]'));
    final containsNumber = text.contains(RegExp(r'[0-9]'));

    if (!containsLetter) {
      return 'Senha deve conter letras';
    }
    if (!containsNumber) {
      return 'Senha deve conter números';
    }

    return null;
  }
}
