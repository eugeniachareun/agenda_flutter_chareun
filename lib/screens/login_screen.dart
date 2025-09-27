import 'package:agenda_flutter_chareun/screens/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de Sesión')),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}
