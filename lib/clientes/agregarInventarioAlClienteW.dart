import 'package:flutter/material.dart';

import '../Inventario/invantarioClass.dart';
import '../db.dart';
import 'clientesClass.dart';
import 'clientesInventarioClass.dart';

class AgregarInventarioAlClienteW extends StatefulWidget {
  AgregarInventarioAlClienteW({Key? key}) : super(key: key);

  @override
  _AgregarInventarioAlClienteWState createState() =>
      _AgregarInventarioAlClienteWState();
}

class _AgregarInventarioAlClienteWState
    extends State<AgregarInventarioAlClienteW> {
  List<InventarioClass> inventrio = [];
  int selectedQuantity = 1;

  cargarInventario() async {
    List<InventarioClass> aux = await DB.getAllInventario();
    setState(() {
      inventrio = aux;
    });
  }

  @override
  void initState() {
    cargarInventario();
    super.initState();
  }

  void _showConfirmationDialog(int index, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Confirmación'),
              content: DropdownButton<int>(
                value: selectedQuantity,
                onChanged: (int? value) {
                  setState(() {
                    selectedQuantity = value!;
                  });
                },
                items: List.generate(
                  inventrio[index].cantidad,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Agregar'),
                  onPressed: () {
                    setState(() {
                      int aux = inventrio[index].cantidad - selectedQuantity;
                      if (aux == 0) {
                        DB.deleteInventario(inventrio[index]);
                      } else {
                        inventrio[index].cantidad = aux;
                        inventrio[index].precio_total =
                            (inventrio[index].precio_individual * aux) * 25;
                        DB.updateInventario(inventrio[index]);
                      }
                    });
                    DB.inserClienteInventario(ClientesInventarioClass(
                        idCliente: id,
                        tipo_joya: inventrio[index].tipo_joya,
                        cantidad: inventrio[index].cantidad,
                        gramaje: inventrio[index].gramaje,
                        material: inventrio[index].material,
                        precio_individual: inventrio[index].precio_individual,
                        precio_total: inventrio[index].precio_total));
                    cargarInventario(); // Actualizar la lista después de agregar
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ClienteClass pc =
        ModalRoute.of(context)!.settings.arguments as ClienteClass;
    if (inventrio.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined),
            Text('Inventario vacío'),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: inventrio.length,
        itemBuilder: (context, index) => Card(
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
              Align(
                alignment: Alignment.center,
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _showConfirmationDialog(index, pc.idCliente!);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
