import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactosDBHelper {
  static Database? _database;
  static const _dbName = 'contactos.db';
  static const _dbVersion = 2;
  static const _tableName = 'contactos';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            apellido TEXT,
            telefono TEXT,
            domicilio TEXT,
            genero TEXT
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int version) async {
        // Código para realizar las modificaciones en la base de datos
      },
    );
  }

  static Future<int> insertContacto(Contacto contacto) async {
    final db = await database;
    return await db.insert(_tableName, contacto.toMap());
  }

  static Future<List<Contacto>> getContactos() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Contacto.id(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        apellido: maps[i]['apellido'],
        telefono: maps[i]['telefono'],
        domicilio: maps[i]['domicilio'],
        genero: maps[i]['genero'] == Genero.femenino.toString() ? Genero.femenino  : Genero.masculino,
      );
    });
  }

  static Future<int> updateContacto(Contacto contacto) async {
    final db = await database;
    return await db.update(_tableName, contacto.toMap(), where: 'id = ?', whereArgs: [contacto.id]);
  }

  static Future<int> deleteContacto(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
