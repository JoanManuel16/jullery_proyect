import 'package:flutter_application_1/Gastos/categoriaClass.dart';
import 'package:flutter_application_1/Gastos/gastosClass.dart';
import 'package:flutter_application_1/Inventario/invantarioClass.dart';
import 'package:flutter_application_1/Inventario/material.dart';
import 'package:flutter_application_1/Inventario/tipoDeJoya.dart';
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
        await db.execute(
          "CREATE TABLE inventario (id_inventario INTEGER PRIMARY KEY, tipo_joya TEXT,cantidad INTEGER,gramaje DOUBLE,material TEXT,precio_individual DOUBLE,precio_total DOUBLE)",
        );
        await db.execute(
          "CREATE TABLE material (id_material INTEGER PRIMARY KEY, material TEXT,precio DOUBLE)",
        );
        await db.execute(
          "CREATE TABLE tipo (id_joya INTEGER PRIMARY KEY, tipo TEXT)",
        );
      },
      version: 4,
    );
  }

//CRUD del provedor
  static Future<void> insertProvedor(proveedor_class pc) async {
    Database database = await _openDB();

    database.insert("provedores", pc.toMap());
    return;
  }

  static Future<void> deleteProvedor(proveedor_class pc) async {
    Database database = await _openDB();

    database.delete("provedores", where: "CI = ?", whereArgs: [pc.Ci]);
    return;
  }

  static Future<void> updateProvedor(proveedor_class pc) async {
    Database database = await _openDB();
    database
        .update("provedores", pc.toMap(), where: "CI = ?", whereArgs: [pc.Ci]);
    return;
  }

  static Future<List<proveedor_class>> getAllProvedores() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("provedores");

    return List.generate(
        provedoresMap.length,
        (i) => proveedor_class(
            nombre: provedoresMap[i]['nombre'],
            Ci: provedoresMap[i]['CI'],
            direccion: provedoresMap[i]['direccion'],
            notas: provedoresMap[i]['notas'],
            movil: provedoresMap[i]['movil'],
            edicion: true));
  }

  //fin del CRUD de provedor

//inicio del CRUD de los gastos
  static Future<void> insertGasto(GastosClass gc) async {
    Database database = await _openDB();
    database.insert("gastos", gc.toMap());
    return;
  }

  static Future<void> deleteGasto(GastosClass gc) async {
    Database database = await _openDB();
    database.delete("gastos",
        where: "fecha = ? and nombre= ?", whereArgs: [gc.fecha, gc.nombre]);
    return;
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
    database.insert("categoria", cc.toMap());
    return;
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

//Inicio del CRUD de los materiales
  static Future<void> insertMaterial(MaterialClass mc) async {
    Database database = await _openDB();
    database.insert("material", mc.toMap());
    return;
  }

  static Future<void> updateMaterial(MaterialClass mc) async {
    Database database = await _openDB();
    database.update("material", mc.toMap(),
        where: "id_material = ?", whereArgs: [mc.id_material]);
    return;
  }

  static Future<List<MaterialClass>> getAllMateriales() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("material");

    return List.generate(
        provedoresMap.length,
        (i) => MaterialClass(
            material: provedoresMap[i]['material'],
            precio: provedoresMap[i]['precio'],
            id_material: 1));
  }

//Fin del CRUD de los materiales

//incio del CRUD del inventario
  static Future<void> insertInventario(InventarioClass ic) async {
    Database database = await _openDB();
    database.insert("inventario", ic.toMap());
    return;
  }

  static Future<void> deleteInventario(InventarioClass ic) async {
    Database database = await _openDB();
    database.delete("inventario",
        where: "id_inventario = ?", whereArgs: [ic.id_inventario]);
    return;
  }

  static Future<void> updateInventario(InventarioClass ic) async {
    Database database = await _openDB();
    database.update("inventario", ic.toMap(),
        where: "id_inventario = ?", whereArgs: [ic.id_inventario]);
    return;
  }

  static Future<List<InventarioClass>> getAllInventario() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("inventario");

    return List.generate(
        provedoresMap.length,
        (i) => InventarioClass(
            cantidad: provedoresMap[i]['cantidad'],
            gramaje: provedoresMap[i]['gramaje'],
            id_inventario: provedoresMap[i]['id_inventario'],
            material: provedoresMap[i]['material'],
            precio_individual: provedoresMap[i]['precio_individual'],
            precio_total: provedoresMap[i]['precio_total'],
            tipo_joya: provedoresMap[i]['tipo_joya']));
  }
// fin del CRUD del inventario

//inico del CRUD de los tipos
  static Future<void> insertTipo(Tipo_joya tj) async {
    Database database = await _openDB();

    database.insert("tipo", tj.toMap());
    return;
  }

  static Future<void> updateTipo(Tipo_joya jc) async {
    Database database = await _openDB();
    database.update("tipo", jc.toMap(),
        where: "id_tipo = ?", whereArgs: [jc.id_tipo]);
    return;
  }

  static Future<List<Tipo_joya>> getAllTipo() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("tipo");

    return List.generate(
        provedoresMap.length,
        (i) => Tipo_joya(
            id_tipo: provedoresMap[i]['id_tipo'],
            tipo: provedoresMap[i]['tipo']));
  }

//fin del CRUD de los tipos
  // CON SENTENCIAS
  static Future<void> insertar2(Animal animal) async {
    Database database = await _openDB();
    var resultado =
        await database.rawInsert("INSERT INTO animales (id, nombre, especie)"
            " VALUES (${animal.id}, ${animal.nombre}, ${animal.especie})");
  }
}
