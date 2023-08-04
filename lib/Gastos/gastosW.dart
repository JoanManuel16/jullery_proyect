import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/gastosClass.dart';

import '../db.dart';

class GtastosW extends StatefulWidget {
  @override
  _GtastosWState createState() => _GtastosWState();
}

class _GtastosWState extends State<GtastosW> {
  List<GastosClass> gastos = [];
  void initState() {
    caragrGastos();
    super.initState();
  }

  caragrGastos() async {
    List<GastosClass> aux = await DB.getAllGastos();
    setState(() {
      gastos = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gastos.length,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Text(gastos[index].nombre),
              title: Text(gastos[index].categoria),
              subtitle: Text(gastos[index].fecha),
              trailing: Text(gastos[index].importe.toString()+"\$"),
            ),
          ],
        ),
      ),
    );
  }
}
