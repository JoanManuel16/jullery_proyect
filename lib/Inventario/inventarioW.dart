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
    // Calcular la suma de los valores de precio_total
    double totalSum = 0;
    for (var item in inventrio) {
      totalSum += item.precio_total;
    }

    return ListView.builder(
      itemCount: inventrio.length + 1, // Agregar 1 para el Card adicional
      itemBuilder: (context, index) {
        if (index == inventrio.length) {
          // Último índice, mostrar el Card adicional con la suma total
          return Container(
            color: Color(0xFF85bb65),
            child: Card(
              color: Color(0xFF85bb65),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                title: Text('Dinero total en inventario: $totalSum'),
              ),
            ),
          );
        } else {
          // Índices anteriores, mostrar los Cards normales
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                      "${inventrio[index].tipo_joya}: ${inventrio[index].cantidad}"),
                  title: Text(
                      "${inventrio[index].material} gramaje: ${inventrio[index].gramaje}"),
                  subtitle: Text(
                      "Precio:${inventrio[index].precio_individual} Total:${inventrio[index].precio_total}"),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        inventrio[index].edicion=true;
                    Navigator.pushNamed(context,"/crearInventario",arguments: inventrio[index]);
                      },
                      child: Icon(Icons.edit),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alerta"),
                              content: Text(
                                  "¿Esta seguro que desea eliminar este objeto del inventario?"),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        false); // Cierra el cuadro de diálogo y devuelve false
                                  },
                                ),
                                ElevatedButton(
                                  child: Text("Si"),
                                  onPressed: () {
                                    Navigator.of(context).pop(
                                        true); // Cierra el cuadro de diálogo y devuelve true
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((confirmacion) {
                          if (confirmacion ?? false) {
                            setState(() {
                              DB.deleteInventario(inventrio[index]);
                              inventrio.removeAt(index);
                            });
                          }
                        });
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
