import 'package:flutter/material.dart';
import 'cargarInvW.dart';

class cargarInventarioCliente extends StatelessWidget {
  final int ?parametro;

  cargarInventarioCliente({ this.parametro, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventario del Cliente"),
      ),
      body: cargarInvW(parametro: parametro!),
    );
  }
}