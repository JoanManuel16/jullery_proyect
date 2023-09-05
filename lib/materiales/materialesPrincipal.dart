import 'package:flutter/material.dart';
import 'package:flutter_application_1/materiales/materialesW.dart';

class MaterialesPrincipal extends StatelessWidget {
  const MaterialesPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editor de los materiales"),
      ),
      body: MaterialesW(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        Navigator.pushNamed(context, "/crearMateriales");
      }),
    );
  }
}
