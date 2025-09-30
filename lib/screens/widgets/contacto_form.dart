import 'package:flutter/material.dart';

class ContactoForm extends StatefulWidget {
  const ContactoForm({super.key});
  @override
  State<ContactoForm> createState() => _ContactoFormState();
}

class _ContactoFormState extends State<ContactoForm> {
  /*
   se utiliza para controlar el contenido de un campo de texto (TextField o TextFormField).
   Permite interactuar con el texto ingresado por el usuario en tiempo real, 
   así como también modificar y obtener el contenido del campo de texto de manera programática.
   */
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _domicilioController = TextEditingController();

  final List<String> opciones = ["Femenino", "Masculino"];

  @override
  Widget build(BuildContext context) {
    _nombreController.text = "Bruno";
    _apellidoController.text = "Díaz";
    _telefonoController.text = "123456";
    _domicilioController.text = "Calle Pública 123";
    String opcion = opciones[0];

    return Padding(
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
            decoration: const InputDecoration(labelText: 'Número de teléfono'),
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
    );
  }
}
