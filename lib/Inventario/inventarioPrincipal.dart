import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventario/invantarioClass.dart';
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
            arguments: InventarioClass(tipo_joya: "", cantidad: 0, gramaje: 0, material: "", precio_individual: 0, precio_total: 0,edicion: false)
          );
        },
        child: const Icon(Icons.add),
      ),
      body: InventarioW(),
    );
  }
}
