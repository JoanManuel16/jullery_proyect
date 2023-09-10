import 'package:flutter/material.dart';

import 'agregarInventarioAlClienteW.dart';

class agregarInventarioAlClientePrincial extends StatelessWidget {
  const agregarInventarioAlClientePrincial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("agregar inventario al cliente"),
      ),
      body: AgregarInventarioAlClienteW(),
    );
  }
}