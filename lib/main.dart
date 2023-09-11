import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/createDrop.dart';
import 'package:flutter_application_1/Gastos/gastosPrincipal.dart';
import 'package:flutter_application_1/Inventario/crearInventario.dart';
import 'package:flutter_application_1/Inventario/inventarioPrincipal.dart';

import 'package:flutter_application_1/principal.dart';
import 'package:flutter_application_1/reportes/reportes.dart';

import 'Proveedor/Provedor.dart';
import 'Proveedor/provedorPrincipal.dart';
import 'clientes/agregarCliente.dart';
import 'clientes/agregarInventarioAlClientePrincial.dart';
import 'clientes/clientesPrincipal.dart';
import 'materiales/agregarmaterial.dart';
import 'materiales/materialesPrincipal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MiApp(),
    );
  }
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/", routes: {
      "/": (context) => const Principal(
            key: Key("A"),
          ),
      "/provedorPrincipal": (context) => const PorvedorPrinciapl(key: Key("B")),
      "/provedor": (context) => Provedor(),
      "/gastos": (context) => const GastosPrincipal(key: Key("C")),
      "/crearDrop": (context) => MyDropdownButton(),
      "/inventarioPrincipal": (context) =>
          const InventarioPricipal(key: Key("D")),
      "/crearInventario": (context) => CrearInventario(key: Key("E")),
      "/editarMateriales": (context) => const MaterialesPrincipal(
            key: Key("F"),
          ),
      "/crearMateriales": (context) => const AregarMaerial(
            key: Key("G"),
          ),
      "/clientePrincipal": (context) => const ClientesPrincipal(
            key: Key("H"),
          ),
      "/crearCliente": (context) => const AgregarCliene(
            key: Key("I"),
          ),
      "/agregarInventarioAlCliente": (context) =>
          const agregarInventarioAlClientePrincial(
            key: Key("J"),
          ),
          "/reportes": (context) => Reportes(key: Key("k")),
    });
  }
}
