import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:agenda_flutter_chareun/providers/agenda_provider.dart';
import 'package:agenda_flutter_chareun/providers/login_provider.dart';
import 'package:agenda_flutter_chareun/screens/formulario_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final TextEditingController _filter = TextEditingController();

  String _searchText = "";
  Icon _searchIcon = const Icon(Icons.search, color: Colors.white);

  Widget _appBarTitle = const Text(
    'Contactos',
    style: TextStyle(color: Colors.white),
  );

  @override
  void initState() {
    super.initState();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });

    // Cargar contactos al inicializar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AgendaProvider>().cargarContactos();
      }
    });
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  get topAppBar => AppBar(
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    elevation: 0.1,
    title: _appBarTitle,
    actions: <Widget>[
      IconButton(icon: _searchIcon, onPressed: search),
      IconButton(
        onPressed: () {
          final loginProvider = Provider.of<LoginProvider>(
            context,
            listen: false,
          );
          loginProvider.logout();
        },
        icon: const Icon(Icons.logout, color: Colors.white),
      ),
      const SizedBox(width: 20.0),
    ],
  );

  void search() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close, color: Colors.white);
        _appBarTitle = TextField(
          controller: _filter,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            hintText: "Buscar...",
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search, color: Colors.white);
        _appBarTitle = const Text('Contactos', style: TextStyle(color: Colors.white));
        _filter.clear();
      }
    });
  }

  List<Contacto> get _filteredContactos {
    final list = context.read<AgendaProvider>().contactos;
    if (_searchText.isEmpty) {
      return list;
    }
    return list
        .where(
          (c) =>
              (c.nombre.toLowerCase().contains(_searchText.toLowerCase()) ||
              c.apellido.toLowerCase().contains(_searchText.toLowerCase())),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AgendaProvider>();

    return Scaffold(
      appBar: topAppBar,
      body: RefreshIndicator(
        onRefresh: () => context.read<AgendaProvider>().cargarContactos(),
        child: _construirLista(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => agregar(context),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _construirLista() {
    final listToShow = _filteredContactos;

    return listToShow.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(bottom: 60.0),
            itemCount: listToShow.length,
            itemBuilder: (BuildContext context, int index) {
              return crearCard(listToShow[index]);
            },
          )
        : const Padding(
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
        leading: const Icon(Icons.person),
        title: Text("${contacto.nombre}  ${contacto.apellido}"),
        subtitle: Text(contacto.telefono),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editar(context, contacto);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<AgendaProvider>().eliminarContacto(contacto.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void more() {}

  void agregar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormularioScreen()),
    );
  }

  void editar(BuildContext context, Contacto contacto) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => FormularioScreen(contacto: contacto),
      ),
    );
  }
}
