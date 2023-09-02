import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventario/invantarioClass.dart';

import '../db.dart';

class InventarioW extends StatefulWidget {
 

  @override
  _InventarioWState createState() => _InventarioWState();
}

class _InventarioWState extends State<InventarioW> {
  List<InventarioClass> inventrio = [];
  caragrInventario() async {
    List<InventarioClass> aux = await DB.getAllInventario();
    setState(() {
      inventrio = aux;
    });
  }

  void initState() {
    caragrInventario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inventrio.length,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Text("${inventrio[index].tipo_joya}: ${inventrio[index].cantidad}"),
              title: Text("${inventrio[index].material} gramaje: ${inventrio[index].gramaje}"),
              subtitle: Text("Precio:${inventrio[index].precio_individual} Total:${inventrio[index].precio_total}"),
            )
          ],
        ),

      ),
    );
  }
}
