import 'package:agenda_flutter_chareun/screens/formulario_screen.dart';
import 'package:agenda_flutter_chareun/screens/widgets/lista_contactos.dart';
import 'package:flutter/material.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () => search()),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () => more())
        ],
        ),
      body: const Center(
        child: ListaContactos(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => agregar(context),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add)
        ),
    );
  }
  void search() {

  }

  void more() {

  }

  void agregar(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const FormularioScreen()));
  }
}