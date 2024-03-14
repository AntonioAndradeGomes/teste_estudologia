import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_login/features/login/bloc/login_bloc.dart';
import 'package:simple_login/features/login/bloc/login_event.dart';
import 'package:simple_login/features/login/bloc/login_state.dart';

void main() {
  group(
    'Tests in LoginBloc',
    () {
      late LoginBloc loginBloc;

      setUp(
        () {
          loginBloc = LoginBloc();
        },
      );

      tearDown(
        () {
          loginBloc.close();
        },
      );

      test(
        'inital state is correct',
        () {
          expect(
            loginBloc.state,
            const LoginState(
              email: '',
              password: '',
              isEmailValid: false,
              isPasswordValid: false,
              textEmailValid: null,
              textPassValid: null,
              loginStatus: LoginStatus.idle,
            ),
          );
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits [isEmailValid = true] when EmailChanged is added with valid email',
        build: () => loginBloc,
        act: (bloc) => bloc.add(
          EmailChanged(
            email: 'test@example.com',
          ),
        ),
        expect: () => [
          const LoginState(
            email: 'test@example.com',
            password: '',
            isEmailValid: true,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.idle,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [isPasswordValid = true] when PasswordChanged is added with valid password',
        build: () => loginBloc,
        act: (bloc) => bloc.add(
          PasswordChanged(
            password: 'password123',
          ),
        ),
        expect: () => [
          const LoginState(
            email: '',
            password: 'password123',
            isEmailValid: false,
            isPasswordValid: true,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.idle,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginState] with loading and success states when SubmitLogin is added',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(SubmitLogin()),
        wait: const Duration(
          seconds: 4,
        ),
        expect: () async => [
          const LoginState(
            email: '',
            password: '',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.loading,
          ),
          const LoginState(
            email: '',
            password: '',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: null,
            loginStatus: LoginStatus.success,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginState] with invalid email error when invalid email is added',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(EmailChanged(email: 'invalidemail')),
        expect: () => [
          const LoginState(
            email: 'invalidemail',
            password: '',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: 'Email inválido',
            textPassValid: null,
            loginStatus: LoginStatus.idle,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits PasswordChanged com isPasswordValid false e texto de validação quando uma senha curta é adicionada',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(PasswordChanged(password: '123')),
        expect: () => [
          const LoginState(
            email: '',
            password: '123',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: 'Senha deve ter mais que 8 dígitos',
            loginStatus: LoginStatus.idle,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits PasswordChanged com isPasswordValid false e texto de validação quando uma senha sem letra é adicionada',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(PasswordChanged(password: '12345678')),
        expect: () => [
          const LoginState(
            email: '',
            password: '12345678',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: 'Senha deve conter letras',
            loginStatus: LoginStatus.idle,
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits PasswordChanged com isPasswordValid false e texto de validação quando uma senha sem número é adicionada',
        build: () => LoginBloc(),
        act: (bloc) => bloc.add(PasswordChanged(password: 'abcdefgh')),
        expect: () => [
          const LoginState(
            email: '',
            password: 'abcdefgh',
            isEmailValid: false,
            isPasswordValid: false,
            textEmailValid: null,
            textPassValid: 'Senha deve conter números',
            loginStatus: LoginStatus.idle,
          ),
        ],
      );
    },
  );
}
