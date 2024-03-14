import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login/features/login/bloc/login_bloc.dart';
import 'package:simple_login/features/login/bloc/login_event.dart';
import 'package:simple_login/features/login/bloc/login_state.dart';
import 'package:simple_login/features/login/pages/home_page.dart';
import 'package:simple_login/features/login/widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: BlocProvider(
            create: (context) => LoginBloc(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (_, state) {
                    if (state.loginStatus == LoginStatus.success) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => HomePage(
                            email: state.email,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return TextFormField(
                      onChanged: (text) {
                        context.read<LoginBloc>().add(
                              EmailChanged(
                                email: text,
                              ),
                            );
                      },
                      readOnly: state.loginStatus == LoginStatus.loading,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Email',
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        errorText: state.textEmailValid,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return TextFormField(
                      onChanged: (text) {
                        context.read<LoginBloc>().add(
                              PasswordChanged(
                                password: text,
                              ),
                            );
                      },
                      readOnly: state.loginStatus == LoginStatus.loading,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Senha',
                        hintText: 'Mínimo de 8 caracteres',
                        prefixIcon: const Icon(
                          Icons.key,
                        ),
                        errorText: state.textPassValid,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return LoginButton(
                      state: state,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
