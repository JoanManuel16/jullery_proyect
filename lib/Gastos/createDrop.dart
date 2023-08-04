import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  String selectedValue;
  caragrCategorias() async {
    List<CategoriaClass> aux = await DB.getAllCategoria();
    setState(() {
      categorias = aux;
       if (categorias.length == 0) {
        DB.insertCategoria(CategoriaClass(categoria: "Gastos Personales"));
        caragrCategorias();
      }
      uniquelist = categorias.where((country) => seen.add(country)).toList();
      selectedValue = uniquelist.isNotEmpty ? uniquelist[0].categoria : null;
    });
  }

  @override
  void initState() {
    caragrCategorias();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
              selectedValue = country;
            });
          },
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {
            String textFieldValue = '';
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Ingrese la categoria q desea agregar'),
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
                          DB.insertCategoria(
                              CategoriaClass(categoria: textFieldValue));
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
      ],
    );
  }
}
