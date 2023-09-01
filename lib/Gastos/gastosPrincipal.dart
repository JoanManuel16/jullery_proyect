import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/categoriaClass.dart';
import 'package:flutter_application_1/Gastos/gastosW.dart';

import '../db.dart';

class GastosPrincipal extends StatefulWidget {
  const GastosPrincipal({required Key key}) : super(key: key);

  @override
  State<GastosPrincipal> createState() => _GastosPrincipalState();
}

class _GastosPrincipalState extends State<GastosPrincipal> {
  DateTime fecha = DateTime.now();
  final costo = TextEditingController();
  List<CategoriaClass> categorias = [];
  caragrProvedores() async {
    List<CategoriaClass> aux = await DB.getAllCategoria();
    setState(() {
      categorias = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de gastos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/crearDrop");
        },
        child: Icon(Icons.add),
      ),
      body: GtastosW(),
    );
  }
}
