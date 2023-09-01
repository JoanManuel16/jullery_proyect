import 'package:flutter/material.dart';
import 'package:flutter_application_1/Proveedor/provedorClas.dart';
import 'package:flutter_application_1/Proveedor/provedorW.dart';

class PorvedorPrinciapl extends StatelessWidget {
  const PorvedorPrinciapl({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de provedores"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/provedor",
                arguments: proveedor_class(
                    nombre: "",
                    Ci: "",
                    movil: "",
                    direccion: "",
                    notas: "",
                    edicion: false));
          },
          child: const Icon(Icons.add)),
      body: PorvedorW(),
    );
  }
}
