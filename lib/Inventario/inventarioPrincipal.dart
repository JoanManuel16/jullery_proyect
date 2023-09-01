import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventario/inventarioW.dart';

class InventarioPricipal extends StatelessWidget {
  const InventarioPricipal({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventrio Existente"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/crearInventario",
          );
        },
        child: const Icon(Icons.add),
      ),
      body: InventarioW(key: Key("value")),
    );
  }
}
