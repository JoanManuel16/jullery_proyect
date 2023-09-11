import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/gastosClass.dart';

import '../db.dart';

class GtastosW extends StatefulWidget {
  final List<GastosClass>? gastos;

  GtastosW({this.gastos});

  @override
  _GtastosWState createState() => _GtastosWState();
}

class _GtastosWState extends State<GtastosW> {
  List<GastosClass> gastos = [];

  @override
  void initState() {
    if (widget.gastos != null) {
      gastos = widget.gastos!;
    } else {
      cargarGastos();
    }
    super.initState();
  }

  cargarGastos() async {
    List<GastosClass> aux = await DB.getAllGastos();
    setState(() {
      gastos = aux;
    });
  }

  @override
  void didUpdateWidget(GtastosW oldWidget) {
    if (oldWidget.gastos != widget.gastos) {
      setState(() {
        gastos = widget.gastos ?? [];
      });
    }
    super.didUpdateWidget(oldWidget);
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
              trailing: Text(gastos[index].importe.toString() + "\$"),
            ),
          ],
        ),
      ),
    );
  }
}
