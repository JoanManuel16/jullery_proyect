import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provedorClas.dart';

import 'db.dart';

class Provedor extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final CI = TextEditingController();
  final movil = TextEditingController();
  final direccion = TextEditingController();
  final notas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProvedorClass pc = ModalRoute.of(context).settings.arguments;
    nombreController.text = pc.nombre;
    CI.text = pc.Ci;
    movil.text = pc.movil;
    direccion.text = pc.direccion;
    notas.text = pc.notas;
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Provedor'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nombreController,
                    validator: (value) {
                      if (value.isEmpty) return "Campo obligaotrio";
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: CI,
                    validator: (value) {
                      if (value.isEmpty) return "Campo Obligatorio";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Carnet de Identidad',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: movil,
                    validator: (value) {
                      if (value.isEmpty) return "Campo Obligatorio";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nuemero de Telefono',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: direccion,
                    validator: (value) {
                      if (value.isEmpty) return "Campo Obligatorio";
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Direccion',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: notas,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Notas',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                          if (pc.edicion) {
                            DB.updateProvedor(ProvedorClass(
                                nombre: nombreController.text,
                                Ci: CI.text,
                                direccion: direccion.text,
                                movil: movil.text,
                                notas: notas.text));
                            Navigator.pushNamed(context, "/provedorPrincipal");
                          }
                        
                        else {
                           DB.insertProvedor(ProvedorClass(
                                nombre: nombreController.text,
                                Ci: CI.text,
                                direccion: direccion.text,
                                movil: movil.text,
                                notas: notas.text));
                            Navigator.pushNamed(context, "/provedorPrincipal");
                        
                        }
                      },
                      child: Text('Guardar'),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
