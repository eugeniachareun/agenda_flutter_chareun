import 'package:agenda_flutter_chareun/providers/agenda_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaContactos extends StatefulWidget {
  const ListaContactos({super.key});
  @override
  State<ListaContactos> createState() => _ListaContactos();
}

class _ListaContactos extends State<ListaContactos> {
  @override
  Widget build(BuildContext context) {
    final agendaProvider = context.watch<AgendaProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: agendaProvider.contactos.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sentiment_very_dissatisfied_sharp, size: 100),
                Text("Todavía no tenés contactos"),
              ],
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: agendaProvider.contactos.length,
                        itemBuilder: (context, index) {
                          final contacto = agendaProvider.contactos[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text(
                                "${contacto.nombre}  ${contacto.apellido}",
                              ),
                              subtitle: Text(contacto.telefono),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.call),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
