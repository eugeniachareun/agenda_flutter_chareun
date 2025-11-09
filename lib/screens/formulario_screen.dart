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

final List<String> opciones = ["Femenino", "Masculino"];

class _FormularioScreen extends State<FormularioScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _domicilioController = TextEditingController();
  String opcion = opciones[0];

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.contacto != null;

    String titulo = "Agregar contacto";
    if (isEditing) {
      _nombreController.text = widget.contacto!.nombre;
      _apellidoController.text = widget.contacto!.apellido;
      _telefonoController.text = widget.contacto!.telefono;
      _domicilioController.text = widget.contacto!.domicilio;
      opcion = widget.contacto!.genero.toString() == Genero.femenino.toString()
          ? opciones[0]
          : opciones[1];
      titulo = "Editar contacto";
    }

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
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Género", style: TextStyle(fontSize: 18)),
                  ListTile(
                    title: Text("Femenino"),
                    leading: Radio(
                      value: opciones[0],
                      groupValue: opcion,
                      onChanged: (valor) {
                        setState(() {
                          opcion = valor.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Masculino"),
                    leading: Radio(
                      value: opciones[1],
                      groupValue: opcion,
                      onChanged: (valor) {
                        setState(() {
                          opcion = valor.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void save() {
    final bool isEditing = widget.contacto != null;
    AgendaProvider agendaProvider = context.read<AgendaProvider>();

    if (isEditing) {
      Contacto contacto = Contacto.id(
        id: widget.contacto!.id,
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        telefono: _telefonoController.text,
        domicilio: _domicilioController.text,
        genero: Genero.values.byName(opcion.toLowerCase()),
      );
      agendaProvider.actualizarContacto(contacto);
    } else {
      Contacto contacto = Contacto.autoincrementar(
        nombre: _nombreController.text,
        apellido: _apellidoController.text,
        telefono: _telefonoController.text,
        domicilio: _domicilioController.text,
        genero: Genero.values.byName(opcion.toLowerCase()),
      );
      agendaProvider.addContacto(contacto);
    }

    mostrarMensaje(context, "Contacto guardado :)", Colors.green, 2);
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
