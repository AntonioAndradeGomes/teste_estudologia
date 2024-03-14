import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login/features/login/bloc/login_bloc.dart';
import 'package:simple_login/features/login/bloc/login_event.dart';
import 'package:simple_login/features/login/bloc/login_state.dart';

class LoginButton extends StatelessWidget {
  final LoginState state;
  const LoginButton({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: state.loginStatus == LoginStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FilledButton(
              onPressed: state.isFormValid
                  ? () {
                      context.read<LoginBloc>().add(SubmitLogin());
                    }
                  : null,
              child: const Text(
                'Entrar',
              ),
            ),
    );
  }
}
