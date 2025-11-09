import 'package:agenda_flutter_chareun/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /*
   se utiliza para controlar el contenido de un campo de texto (TextField o TextFormField).
   Permite interactuar con el texto ingresado por el usuario en tiempo real, 
   así como también modificar y obtener el contenido del campo de texto de manera programática.
   */
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _usuarioController.text = "admin";
    _passwordController.text = "123";

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
            Icon(Icons.person, size: 60),
            Text("Mi Agenda", style: Theme.of(context).textTheme.titleLarge)    
            ]
            ),
          TextField(
            controller: _usuarioController,
            decoration: const InputDecoration(labelText: 'Usuario'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: const Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }

  void login() {
    //Utilizamos LoginProvider para validar las credenciales
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.login(_usuarioController.text, _passwordController.text).catchError((error) {
      mostrarMensaje(context, "ERROR:  Credenciales incorrectas", Colors.red, 2);
    });
  }

  void mostrarMensaje(context, String message, color, duracion) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duracion ?? 2),
        backgroundColor: color ?? const Color.fromARGB(255, 61, 155, 233),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
