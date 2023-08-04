import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/createDrop.dart';
import 'package:intl/intl.dart';
import '../db.dart';
import 'categoriaClass.dart';
import 'package:uuid/uuid.dart';

class Agregargasto extends StatefulWidget {
  const Agregargasto({Key key}) : super(key: key);

  @override
  State<Agregargasto> createState() => _AgregargastoState();
}

class _AgregargastoState extends State<Agregargasto> {
  DateTime fecha = DateTime.now();
  final costo = TextEditingController();



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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Gasto"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
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
                  const SizedBox(
                    height: 20,
                  ),
                  MyDropdownButton(),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text("Guardar"),
                    onPressed: () {
                      //TODO
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
