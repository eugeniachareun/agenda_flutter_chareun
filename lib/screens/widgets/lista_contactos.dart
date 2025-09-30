import 'package:flutter/material.dart';

class ListaContactos extends StatefulWidget {
  const ListaContactos({super.key});
  @override
  State<ListaContactos> createState() => _ListaContactos();
}

class _ListaContactos extends State<ListaContactos> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_very_dissatisfied_sharp, size: 100),
          Text("Todavía no tenés contactos")
        ],
      ),
    );
  }
}
