import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db.dart';
import 'clientesInventarioClass.dart';

class cargarInvW extends StatefulWidget {
  final int parametro;

  cargarInvW({required this.parametro});

  @override
  _cargarInvWState createState() => _cargarInvWState();
}

class _cargarInvWState extends State<cargarInvW> {
  List<ClientesInventarioClass> inventrio = [];

  caragrInventario() async {
    List<ClientesInventarioClass> aux = await DB.getALLClientesInventario(widget.parametro);
    setState(() {
      inventrio = aux;
    });
  }

  @override
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
            child: Stack(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Text(
                          "${inventrio[index].tipo_joya}: ${inventrio[index].cantidad}"),
                      title: Text(
                          "${inventrio[index].material} gramaje: ${inventrio[index].gramaje}"),
                      subtitle: Text(
                          "Precio:${inventrio[index].precio_individual} Total:${inventrio[index].precio_total}"),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmar eliminación'),
                            content: Text('¿Estás seguro de que deseas eliminar este elemento?'),
                            actions: [
                              TextButton(
                                child: Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Eliminar'),
                                onPressed: () async {
                                  await DB.deleteClienteInventrioClass(inventrio[index]);
                                  Navigator.of(context).pop();
                                  setState(() {
                                    inventrio.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}