import 'package:flutter_application_1/Gastos/categoriaClass.dart';
import 'package:flutter_application_1/Gastos/gastosClass.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Proveedor/provedorClas.dart';
import 'animal.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'animales.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE provedores (id_provedor INTEGER PRIMARY KEY, nombre TEXT, CI TEXT, movil TEXT, direccion TEXT, notas TEXT, edicion BOOLEAN)",
        );
        await db.execute(
          "CREATE TABLE gastos (id_gastos INTEGER PRIMARY KEY, fecha TEXT, importe INTEGER, categoria TEXT, nombre TEXT)",
        );
        await db.execute(
          "CREATE TABLE categoria (id_categoria INTEGER PRIMARY KEY, categoria TEXT)",
        );
      },
      version: 4,
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

    return database
        .update("provedores", pc.toMap(), where: "CI = ?", whereArgs: [pc.Ci]);
  }

  static Future<List<ProvedorClass>> getAllProvedores() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("provedores");

    return List.generate(
        provedoresMap.length,
        (i) => ProvedorClass(
            nombre: provedoresMap[i]['nombre'],
            Ci: provedoresMap[i]['CI'],
            direccion: provedoresMap[i]['direccion'],
            notas: provedoresMap[i]['notas'],
            movil: provedoresMap[i]['movil']));
  }

  //fin del CRUD de provedor

//inicio del CRUD de los gastos
  static Future<void> insertGasto(GastosClass gc) async {
    Database database = await _openDB();

    return database.insert("gastos", gc.toMap());
  }

  static Future<void> deleteGasto(GastosClass gc) async {
    Database database = await _openDB();

    return database.delete("gastos",
        where: "fecha = ? and nombre= ?", whereArgs: [gc.fecha, gc.nombre]);
  }

  static Future<List<GastosClass>> getAllGastos() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("gastos");

    return List.generate(
        provedoresMap.length,
        (i) => GastosClass(
            categoria: provedoresMap[i]['categoria'],
            fecha: provedoresMap[i]['fecha'],
            importe: provedoresMap[i]['importe'],
            nombre: provedoresMap[i]['nombre']));
  }

//fin del CRUD de los gastos
  static Future<void> insertCategoria(CategoriaClass cc) async {
    Database database = await _openDB();

    return database.insert("categoria", cc.toMap());
  }

  static Future<List<CategoriaClass>> getAllCategoria() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("categoria");

    return List.generate(
        provedoresMap.length,
        (i) => CategoriaClass(
            categoria: provedoresMap[i]['categoria'],
            id: provedoresMap[i]['id_categoria']));
  }
//Inicio del CRUD de categorias de gastos

//Fin del CRUD de categorias de gastos

  // CON SENTENCIAS
  static Future<void> insertar2(Animal animal) async {
    Database database = await _openDB();
    var resultado =
        await database.rawInsert("INSERT INTO animales (id, nombre, especie)"
            " VALUES (${animal.id}, ${animal.nombre}, ${animal.especie})");
  }
}
