import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db.dart';
import 'categoriaClass.dart';

class Agregargasto extends StatefulWidget {
  @override
  State<Agregargasto> createState() => _AgregargastoState();
}

class _AgregargastoState extends State<Agregargasto> {
  DateTime fecha = DateTime.now();

  final costo = TextEditingController();

  List<CategoriaClass> categorias = [];
  void initState() {
    caragrCategorias();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
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
    });
  }

  caragrCategorias() async {
    List<CategoriaClass> aux = await DB.getAllCategoria();
    setState(() {
      categorias = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Gasto"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  Text("Fecha"),
                  ElevatedButton(
                    child: Text(DateFormat('yyyy-MM-dd').format(fecha)),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: costo,
                validator: (value) {
                  if (value.isEmpty) return "Campo Obligatorio";
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
              Row(
                children: [
                  DropdownButton<String>(
                    value: categorias[0].categoria,
                    items: categorias.map((CategoriaClass elemento) {
                      return DropdownMenuItem<String>(
                        value: elemento.categoria,
                        child: Text(elemento.categoria),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        categorias[0].categoria = "$newValue";
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(onPressed: () {
                    //para agregar las categorias
                  },child: Icon(Icons.add),),
                  )
                ],
              ),
              ElevatedButton(
                child: Text("Guardar"),
                onPressed: () {
                  //TODO
                },
              ),
            ],
          ),
        ));
  }
}
