import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inventario/material.dart';
import 'package:flutter_application_1/db.dart';

class AregarMaerial extends StatefulWidget {
  const AregarMaerial({Key? key}) : super(key: key);

  @override
  State<AregarMaerial> createState() => _AregarMaerialState();
}

class _AregarMaerialState extends State<AregarMaerial> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombre = TextEditingController();
  TextEditingController numero = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar material"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombre,
                decoration: InputDecoration(
                  labelText: 'Nombre del material',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre del material';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: numero,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Coste del material',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el coste del material';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DB.insertMaterial(
                      MaterialClass(
                        material: nombre.text,
                        precio: double.parse(numero.text),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, "/editarMateriales");
                  }
                },
                child: Text('Guardar Material'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}