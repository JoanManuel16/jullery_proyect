import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Proveedor/provedorClas.dart';

import '../db.dart';

class Provedor extends StatelessWidget {
  final nombreController = TextEditingController();
  final CI = TextEditingController();
  final movil = TextEditingController();
  final direccion = TextEditingController();
  final notas = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProvedorClass pc =
        ModalRoute.of(context)!.settings.arguments as ProvedorClass;
    nombreController.text = pc.getNombre();
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nombreController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: CI,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Carnet de Identidad',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: movil,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Número de Teléfono',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: direccion,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dirección',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: notas,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Notas',
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (pc.edicion) {
                            DB.updateProvedor(
                              ProvedorClass(
                                nombre: nombreController.text,
                                Ci: CI.text,
                                direccion: direccion.text,
                                movil: movil.text,
                                notas: notas.text,
                                edicion: true,
                              ),
                            );
                          } else {
                            DB.insertProvedor(
                              ProvedorClass(
                                nombre: nombreController.text,
                                Ci: CI.text,
                                direccion: direccion.text,
                                movil: movil.text,
                                notas: notas.text,
                                edicion: true,
                              ),
                            );
                          }
                          Navigator.pushNamed(context, "/provedorPrincipal");
                        }
                      },
                      child: Text('Guardar'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}