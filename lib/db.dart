import 'package:flutter_application_1/Gastos/categoriaClass.dart';
import 'package:flutter_application_1/Gastos/gastosClass.dart';
import 'package:flutter_application_1/Inventario/invantarioClass.dart';
import 'package:flutter_application_1/Inventario/material.dart';
import 'package:flutter_application_1/Inventario/tipoDeJoya.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Proveedor/provedorClas.dart';
import 'clientes/clientesClass.dart';
import 'clientes/clientesInventarioClass.dart';

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
        await db.execute(
          "CREATE TABLE clientes (idCliente INTEGER PRIMARY KEY, nombre TEXT, ci TEXT, movil TEXT, direccion TEXT, notas TEXT)",
        );
        await db.execute(
          "CREATE TABLE clienteInventario (idClienteInventario INTEGER PRIMARY KEY, idCliente INTEGER, tipo_joya TEXT,cantidad INTEGER,gramaje DOUBLE,material TEXT,precio_individual DOUBLE,precio_total DOUBLE)",
        );
      },
      version: 4,
    );
  }

//CRUD del provedor
  static Future<void> insertProvedor(ProvedorClass pc) async {
    Database database = await _openDB();

    database.insert("provedores", pc.toMap());
    return;
  }

  static Future<void> deleteProvedor(ProvedorClass pc) async {
    Database database = await _openDB();

    database.delete("provedores", where: "CI = ?", whereArgs: [pc.Ci]);
    return;
  }

  static Future<void> updateProvedor(ProvedorClass pc) async {
    Database database = await _openDB();
    database
        .update("provedores", pc.toMap(), where: "CI = ?", whereArgs: [pc.Ci]);
    return;
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
              id_material: provedoresMap[i]['id_material'],
              material: provedoresMap[i]['material'],
              precio: provedoresMap[i]['precio'],
            ));
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
    final List<Map<String, dynamic>> provedoresMap = await database.query(
      "inventario",
    );

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

  static Future<List<InventarioClass>> getAllInventarioByMaterial(
      String materia) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap = await database
        .query("inventario", where: "material = ?", whereArgs: [materia]);

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

//inico del CRUD de los clientes
  static Future<void> inserCliente(ClienteClass cc) async {
    Database database = await _openDB();

    database.insert("clientes", cc.toMap());
    return;
  }

  static Future<void> deleteCliente(ClienteClass cc) async {
    Database database = await _openDB();

    database.delete("clientes", where: "CI = ?", whereArgs: [cc.ci]);
    database.delete("clienteInventario", where: "idCliente = ?", whereArgs: [cc.idCliente]);
    return;
  }

  static Future<void> updateCliente(ClienteClass cc) async {
    Database database = await _openDB();
    database
        .update("clientes", cc.toMap(), where: "idCliente = ?", whereArgs: [cc.idCliente]);
    return;
  }

  static Future<List<ClienteClass>> getALLClientes() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("clientes");

    return List.generate(
        provedoresMap.length,
        (i) => ClienteClass(
            nombre: provedoresMap[i]['nombre'],
            ci: provedoresMap[i]['ci'],
            direccion: provedoresMap[i]['direccion'],
            notas: provedoresMap[i]['notas'],
            movil: provedoresMap[i]['movil'],
            idCliente: provedoresMap[i]['idCliente'],
            ));
  }

//fin del CRUD de los clientes


//incio del CRUD de los clientesInventario
static Future<void> inserClienteInventario(ClientesInventarioClass cic) async {
    Database database = await _openDB();

    database.insert("clienteInventario", cic.toMap());
    return;
  }

  static Future<void> deleteClienteInventrioClass(ClientesInventarioClass cic) async {
    Database database = await _openDB();

    database.delete("clienteInventario", where: "idClienteInventario = ?", whereArgs: [cic.idClienteInventario]);
    return;
  }
  static Future<List<ClientesInventarioClass>> getALLClientesInventario(int idClienteInventario) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> provedoresMap =
        await database.query("clienteInventario");

    return List.generate(
        provedoresMap.length,
        (i) => ClientesInventarioClass(
            cantidad: provedoresMap[i]['cantidad'],
            gramaje: provedoresMap[i]['gramaje'],
            material: provedoresMap[i]['material'],
            precio_individual: provedoresMap[i]['precio_individual'],
            precio_total: provedoresMap[i]['precio_total'],
            tipo_joya: provedoresMap[i]['tipo_joya'],
            idClienteInventario: provedoresMap[i]['idClienteInventario'],
            idCliente: provedoresMap[i]['idCliente'],
            ));
  }


//fin del CRUD de los clientesInventario


  // CON SENTENCIAS
/*  static Future<void> insertar2(Animal animal) async {
    Database database = await _openDB();
    var resultado =
        await database.rawInsert("INSERT INTO animales (id, nombre, especie)"
            " VALUES (${animal.id}, ${animal.nombre}, ${animal.especie})");
  }*/
}
