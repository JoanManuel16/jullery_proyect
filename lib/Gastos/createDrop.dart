import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/gastosClass.dart';
import 'package:intl/intl.dart';

import '../db.dart';
import 'categoriaClass.dart';

class MyDropdownButton extends StatefulWidget {
  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  List<CategoriaClass> categorias = [];
  var seen = Set<CategoriaClass>();
  List<CategoriaClass> uniquelist = [];
  String selectedValue = "";
  DateTime fecha = DateTime.now();
  final costo = TextEditingController();
  final nombre = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  caragrCategorias() async {
    List<CategoriaClass> aux = await DB.getAllCategoria();
    setState(() {
      categorias = aux;
      if (categorias.length == 0) {
        DB.insertCategoria(
            CategoriaClass(categoria: "Gastos Personales", id: 1));
        caragrCategorias();
      }
      uniquelist = categorias.where((country) => seen.add(country)).toList();
      selectedValue = uniquelist.isNotEmpty ? uniquelist[0].categoria : "";
    });
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100))
        .then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          fecha = selectedDate;
        });
      }
      return fecha;
    });
    return picked;
  }

  @override
  void initState() {
    caragrCategorias();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Gasto'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text("Fecha"),
                          Container(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              child: Text(DateFormat('yyyy-MM-dd').format(fecha)),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: costo,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo Obligatorio";
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Costo',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: nombre,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo Obligatorio";
                          return null;
                        },
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nombre',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          DropdownButton(
                            value: selectedValue,
                            items: uniquelist.map((country) {
                              return DropdownMenuItem(
                                child: Text(country.categoria),
                                value: country.categoria,
                              );
                            }).toList(),
                            onChanged: (country) {
                              setState(() {
                                print(country);
                                selectedValue = country as String;
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
                                          'Ingrese la categoria q desea agregar'),
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
                                              DB.insertCategoria(CategoriaClass(
                                                  categoria: textFieldValue,
                                                  ));
                                              caragrCategorias();
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
                      ElevatedButton(
                        child: Text("Guardar"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            int resultado = int.parse(costo.text);
                            DB.insertGasto(GastosClass(
                                categoria: selectedValue,
                                fecha: DateFormat('yyyy-MM-dd').format(fecha),
                                importe: resultado,
                                nombre: nombre.text));
                            Navigator.pushNamed(context, "/gastos");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}