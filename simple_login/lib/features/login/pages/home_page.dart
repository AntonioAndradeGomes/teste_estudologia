import 'package:flutter/material.dart';
import 'package:simple_login/features/login/pages/login_page.dart';

class HomePage extends StatelessWidget {
  final String email;
  const HomePage({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Email: $email',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
            child: const Text(
              'Sair',
            ),
          ),
        ],
      ),
    );
  }
}
