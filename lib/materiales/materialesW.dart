import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventario/material.dart';

import '../Inventario/invantarioClass.dart';
import '../db.dart';

class MaterialesW extends StatefulWidget {
  MaterialesW({Key? key}) : super(key: key);

  @override
  _MaterialesWState createState() => _MaterialesWState();
}

class _MaterialesWState extends State<MaterialesW> {
  List<MaterialClass> material = [];
  List<InventarioClass> inventrio = [];
  TextEditingController nombre = TextEditingController();
  TextEditingController costo = TextEditingController();
  _caragrmateriales() async {
    List<MaterialClass> aux = await DB.getAllMateriales();
    setState(() {
      material = aux;
    });
  }

  _caragrInventario() async {
    List<InventarioClass> aux = await DB.getAllInventario();
    setState(() {
      inventrio = aux;
    });
  }

  void initState() {
    _caragrmateriales();
    super.initState();
  }

  _editarMaterialesInventario(List<InventarioClass> inventoarioBymaterial,
      double coste, String material) {
    for (var inventarioClass in inventoarioBymaterial) {
      inventarioClass.material = material;
      inventarioClass.precio_individual = coste * inventarioClass.gramaje;
      inventarioClass.precio_total =
          inventarioClass.precio_individual * inventarioClass.cantidad;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: material.length,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.circle),
              title: Text(material[index].material),
              subtitle: Text("Precio \$${material[index].precio}"),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String textFieldValueNombre = material[index].material;
                    String textFieldValueCosto =
                        material[index].precio.toString();
                    nombre.text = textFieldValueNombre;
                    costo.text = textFieldValueCosto;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Ingrese el tipo de joya a agregar'),
                          content: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  textFieldValueNombre = value;
                                },
                                controller: nombre,
                                decoration: InputDecoration(
                                  labelText: 'Ingrese el nombre del Material',
                                ),
                              ),
                              TextField(
                                controller: costo,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  textFieldValueCosto = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Ingrese el coste del material',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _caragrmateriales();
                                  _editarMaterialesInventario(
                                    inventrio,
                                    double.parse(textFieldValueCosto),
                                    textFieldValueNombre,
                                  );
                                  for (var element in inventrio) {
                                    DB.updateInventario(element);
                                  }
                                  material[index].material =
                                      textFieldValueNombre;
                                  material[index].precio =
                                      double.parse(textFieldValueCosto);
                                  DB.updateMaterial(material[index]);
                                  Navigator.of(context).pop();
                                 _caragrmateriales();
                                });
                              },
                              child: Text('Aceptar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.edit),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
