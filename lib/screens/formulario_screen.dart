import 'package:agenda_flutter_chareun/screens/widgets/contacto_form.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatelessWidget {
  const FormularioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: () => save()),
        ],
        ),
      body: ContactoForm()
      );
  }
  
  void save() {

  }
}