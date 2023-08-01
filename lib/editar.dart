import 'package:flutter/material.dart';
import 'animal.dart';
import 'db.dart';

class Editar extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final especieController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Animal animal = ModalRoute.of(context).settings.arguments;
    nombreController.text = animal.nombre;
    especieController.text = animal.especie;

    return Scaffold(
      
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Guardar")
      ),
      body:Container(
        child: Padding(
    padding: EdgeInsets.all(16.0),
              child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nombreController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "El nombre es obligatorio";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Nombre"
                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: especieController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "La especie es obligatoria";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Especie"
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState != null){
                              if (_formKey.currentState.validate()) {
                                  if (animal.id > 0) {
                                    animal.nombre = nombreController.text;
                                    animal.especie = especieController.text;
                                 //   DB.update(animal);
                                  }
                          }
                          }
                            else
                             // DB.insert(Animal(nombre: nombreController.text, especie: especieController.text));
                            Navigator.pushNamed(context,"/");
                        },
                        child: Text("Guardar"))
                  ]
              )
          
  )
      )
    );
  }

}