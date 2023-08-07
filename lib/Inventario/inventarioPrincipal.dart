import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventario/inventarioW.dart';

class inventarioPricipal extends StatelessWidget {
  const inventarioPricipal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventrio Existente"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/crearInventario",
          );
        },
        child: Icon(Icons.add),
      ),
      body: InventarioW(),
    );
  }
}
