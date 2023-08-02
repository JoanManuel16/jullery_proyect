

import 'package:flutter_application_1/provedorClas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'animal.dart';

class DB {

static Future<Database> _openDB() async {
  return openDatabase(join(await getDatabasesPath(), 'animales.db'),
    onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE provedores (id_provedor INTEGER PRIMARY KEY, nombre TEXT, CI TEXT, movil TEXT, direccion TEXT, notas TEXT, edicion BOOLEAN)",
      );
    },
    version: 2,
  );
}
//CRUD del provedor
static Future<void> insertProvedor(ProvedorClass pc) async {
    Database database = await _openDB();

    return database.insert("provedores", pc.toMap());
  }
   static Future<void> deleteProvedor(ProvedorClass pc) async {
    Database database = await _openDB();

    return database.delete("provedores", where: "CI = ?", whereArgs: [pc.Ci]);
  }
  static Future<void> updateProvedor(ProvedorClass pc) async {
    Database database = await _openDB();

    return database.update("provedores", pc.toMap(), where: "CI = ?", whereArgs: [pc.Ci]);
  }
 
  static Future<List<ProvedorClass>> getAllProvedores() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap = await database.query("provedores");

    return List.generate(provedoresMap.length,
            (i) => ProvedorClass(
              nombre: provedoresMap[i]['nombre'],
              Ci: provedoresMap[i]['CI'],
              direccion: provedoresMap[i]['direccion'],
              notas: provedoresMap[i]['notas'],
              movil: provedoresMap[i]['movil']
            ));
  }
  //fin del CRUD de provedor


  // CON SENTENCIAS
  static Future<void> insertar2(Animal animal) async {
    Database database = await _openDB();
    var resultado = await database.rawInsert("INSERT INTO animales (id, nombre, especie)"
    " VALUES (${animal.id}, ${animal.nombre}, ${animal.especie})");
  }
}