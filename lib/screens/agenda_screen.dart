import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:agenda_flutter_chareun/providers/agenda_provider.dart';
import 'package:agenda_flutter_chareun/screens/formulario_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  TextEditingController _filter = TextEditingController();

  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search, color: Colors.white);

  List<Contacto> contactoFiltro = <Contacto>[];

  late AgendaProvider agendaProvider;

  _AgendaScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          contactoFiltro = agendaProvider.contactos;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Widget _appBarTitle = Text(
    'Contactos',
    style: TextStyle(color: Colors.white),
  );

  get topAppBar => AppBar(
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    elevation: 0.1,
    title: _appBarTitle,
    actions: <Widget>[IconButton(icon: _searchIcon, onPressed: search)],
  );

  void search() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close, color: Colors.white);
        _appBarTitle = TextField(
          controller: _filter,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: "Buscar...",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        );
      } else {
        _searchIcon = Icon(Icons.search, color: Colors.white);
        _appBarTitle = Text('Contactos', style: TextStyle(color: Colors.white));
        contactoFiltro = agendaProvider.contactos;
        _filter.clear();
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    agendaProvider = context.watch<AgendaProvider>();
    getContactos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar,
      body: RefreshIndicator(
        onRefresh: getContactos,
        child: Container(child: _construirLista()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => agregar(context),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _construirLista() {
    if (_searchText.isNotEmpty) {
      contactoFiltro = agendaProvider.contactos
          .where(
            (c) =>
                (c.nombre.toLowerCase().contains(_searchText.toLowerCase()) ||
                c.apellido.toLowerCase().contains(_searchText.toLowerCase())),
          )
          .toList();
    }

    return contactoFiltro.isNotEmpty
        ? ListView.builder(
            padding: EdgeInsets.only(bottom: 60.0),
            itemCount: contactoFiltro.length,
            itemBuilder: (BuildContext context, int index) {
              return crearCard(contactoFiltro[index]);
            },
          )
        : Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_very_dissatisfied_sharp, size: 100),
                  Text("Todavía no tenés contactos"),
                ],
              ),
            ),
          );
  }

  Card crearCard(Contacto contacto) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text("${contacto.nombre}  ${contacto.apellido}"),
        subtitle: Text(contacto.telefono),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.call)),
      ),
    );
  }

  Future<void> getContactos() async {
    setState(() {
      contactoFiltro = agendaProvider.contactos;
    });
  }

  void more() {}

  void agregar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormularioScreen()),
    );
  }
}
