import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Inventario/material.dart';
import 'package:flutter_application_1/Inventario/tipoDeJoya.dart';

import '../db.dart';

class CrearInventario extends StatefulWidget {
  CrearInventario({Key key}) : super(key: key);

  @override
  _CrearInventarioState createState() => _CrearInventarioState();
}

class _CrearInventarioState extends State<CrearInventario> {
  List<MaterialClass> materiales = [];
  List<Tipo_joya> tipo_joya = [];
  List<MaterialClass> uniquelistMaterial = [];
  List<Tipo_joya> uniquelistJoya = [];
  final cantidad = TextEditingController();
  final gramaje = TextEditingController();
  var seenMaterial = Set<MaterialClass>();
  var seenJoya = Set<Tipo_joya>();
  double _precio;
  String selectedValueMaterial;
  String selectedValueJoya;
  caragrMaeriales() async {
    List<MaterialClass> aux = await DB.getAllMateriales();
    setState(() {
      materiales = aux;
      if (materiales.length == 0) {
        DB.insertMaterial(MaterialClass(material: "Oro", precio: 250));
        caragrMaeriales();
      }
      uniquelistMaterial =
          materiales.where((country) => seenMaterial.add(country)).toList();
      selectedValueMaterial =
          uniquelistMaterial.isNotEmpty ? uniquelistMaterial[0].material : null;
    });
  }

  caragrJoya() async {
    List<Tipo_joya> aux = await DB.getAllTipo();
    setState(() {
      tipo_joya = aux;
      if (tipo_joya.length == 0) {
        DB.insertTipo(Tipo_joya(tipo: "Anillo"));
        caragrJoya();
      }
      uniquelistJoya =
          tipo_joya.where((country) => seenJoya.add(country)).toList();
      selectedValueJoya =
          uniquelistJoya.isNotEmpty ? uniquelistJoya[0].tipo : null;
    });
  }

  @override
  void initState() {
    caragrJoya();
    caragrMaeriales();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventario"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: cantidad,
                      validator: (value) {
                        if (value.isEmpty) return "Campo Obligatorio";
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cantidad de Piezas',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: gramaje,
                      validator: (value) {
                        if (value.isEmpty) return "Campo Obligatorio";
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gramaje',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: selectedValueJoya,
                          items: uniquelistJoya.map((country) {
                            return DropdownMenuItem(
                              child: Text(country.tipo),
                              value: country.tipo,
                            );
                          }).toList(),
                          onChanged: (country) {
                            setState(() {
                              selectedValueJoya = country;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 30,
                          width: 30,
                          child: FloatingActionButton(
                            onPressed: () {
                              String textFieldValue = '';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Ingrese el tipo de joya a agregar'),
                                    content: TextField(
                                      onChanged: (value) {
                                        textFieldValue = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Ingrese texto',
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            DB.insertTipo(Tipo_joya(
                                                tipo: textFieldValue));
                                            caragrJoya();
                                            Navigator.of(context).pop();
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
                            child: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: selectedValueMaterial,
                          items: uniquelistMaterial.map((country) {
                            return DropdownMenuItem(
                              child: Text(country.material),
                              value: country.material,
                            );
                          }).toList(),
                          onChanged: (country) {
                            setState(() {
                              selectedValueMaterial = country;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 30,
                          width: 30,
                          child: FloatingActionButton(
                            onPressed: () {
                              String textFieldValue = '';
                              String textFieldValuePrecio = '';

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: AlertDialog(
                                      title: Text(
                                          'Ingrese el tipo de material y el precio'),
                                      content: Column(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              textFieldValue = value;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Material',
                                            ),
                                          ),
                                          TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            onChanged: (value) {
                                              textFieldValuePrecio = value;
                                              _precio = double.parse(
                                                  textFieldValuePrecio);
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Precio',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              DB.insertMaterial(MaterialClass(
                                                  material: textFieldValue,
                                                  precio: _precio));
                                              caragrMaeriales();
                                              Navigator.of(context).pop();
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
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: Text("Guardar"),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
