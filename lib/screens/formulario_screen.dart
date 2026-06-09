import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:agenda_flutter_chareun/providers/agenda_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key, this.contacto});

  //Solo tenemos contacto si estamos editando, si estamos agrengando contacto es nulo
  final Contacto? contacto;

  @override
  State<FormularioScreen> createState() => _FormularioScreen();
}

class _FormularioScreen extends State<FormularioScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _domicilioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contacto != null) {
      _nombreController.text = widget.contacto!.nombre;
      _apellidoController.text = widget.contacto!.apellido;
      _telefonoController.text = widget.contacto!.telefono;
      _domicilioController.text = widget.contacto!.domicilio ?? "";
      _emailController.text = widget.contacto!.email;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _domicilioController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.contacto != null;
    final String titulo = isEditing ? "Editar contacto" : "Agregar contacto";

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: () => save()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                labelText: 'Número de teléfono',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _domicilioController,
              decoration: const InputDecoration(labelText: 'Domicilio'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }

  void save() async {
    final bool isEditing = widget.contacto != null;
    AgendaProvider agendaProvider = context.read<AgendaProvider>();

    Contacto contacto;
    if (isEditing) {
      contacto = Contacto.id(
        id: widget.contacto!.id,
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        telefono: _telefonoController.text,
        domicilio: _domicilioController.text,
        email: _emailController.text,
      );
    } else {
      contacto = Contacto(
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        telefono: _telefonoController.text,
        domicilio: _domicilioController.text,
        email: _emailController.text,
      );
    }

    if (isEditing) {
      await agendaProvider.actualizarContacto(contacto);
    } else {
      await agendaProvider.addContacto(contacto);
    }

    if (mounted) {
      mostrarMensaje(context, "Contacto guardado :)", Colors.green, 2);
      Navigator.pop(context);
    }
  }

  void mostrarMensaje(context, String message, color, duracion) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duracion ?? 2),
        backgroundColor: color ?? const Color.fromARGB(255, 61, 155, 233),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
