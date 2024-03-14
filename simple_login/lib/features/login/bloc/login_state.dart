import 'package:equatable/equatable.dart';

enum LoginStatus { idle, loading, success }

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final String? textEmailValid;
  final String? textPassValid;
  final LoginStatus loginStatus;

  const LoginState({
    required this.email,
    required this.password,
    required this.isEmailValid,
    required this.isPasswordValid,
    this.textEmailValid,
    this.textPassValid,
    this.loginStatus = LoginStatus.idle,
  });

  LoginState copyWith(
      {String? email,
      String? password,
      bool? isEmailValid,
      bool? isPasswordValid,
      String? textEmailValid,
      String? textPassValid,
      LoginStatus? loginStatus}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      textEmailValid: textEmailValid,
      textPassValid: textPassValid,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  bool get isFormValid => isEmailValid && isPasswordValid;

  @override
  String toString() {
    return 'LoginState(email: $email, password: $password, isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid, textEmailValid: $textEmailValid, textPassValid: $textPassValid, loginStatus: $loginStatus)';
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        textEmailValid,
        textPassValid,
        loginStatus
      ];
}
