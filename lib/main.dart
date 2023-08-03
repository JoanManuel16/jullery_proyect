import 'package:flutter/material.dart';

import 'package:flutter_application_1/principal.dart';

import 'Proveedor/Provedor.dart';
import 'Proveedor/provedorPrincipal.dart';
import 'editar.dart';
import 'listado.dart';

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
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" : (context) => Principal(),
        "/provedorPrincipal" : (context) => PorvedorPrinciapl(),
        "/provedor" : (context) => Provedor(),
      }
    );
  }
}