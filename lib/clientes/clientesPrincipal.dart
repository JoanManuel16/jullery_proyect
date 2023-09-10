import 'package:flutter/material.dart';

import 'clientesClass.dart';
import 'clientesW.dart';

class ClientesPrincipal extends StatelessWidget {
  const ClientesPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      body: ClientesW(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        Navigator.pushNamed(context, "/crearCliente", arguments: ClienteClass(ci: "", direccion: "", movil: "", nombre: "",editar: false,notas: "",idCliente: 0));
      }),
    );
  }
}
