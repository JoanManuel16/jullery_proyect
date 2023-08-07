import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/categoriaClass.dart';
import 'package:flutter_application_1/db.dart';

class Principal extends StatelessWidget {
  const Principal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/provedorPrincipal");
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_add_alt_rounded,
                                size: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Provedores')
                            ],
                          ),
                        )),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/inventarioPrincipal");
                      },
                      child: Icon(Icons.inventory_2_outlined),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/gastos");
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.attach_money_outlined,
                              size: 50,
                            ),
                            Text("Gastos")
                          ],
                        )),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.ac_unit_sharp),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.ac_unit_sharp),
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    height: 100,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.ac_unit_sharp),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Expanded(
                    child: Container(
                  height: 150,
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      print("lo hice");
                      DB.insertCategoria(CategoriaClass(categoria: "gastos personales"));
                      DB.insertCategoria(CategoriaClass(categoria: "Otros"));
                    },
                    child: Icon(Icons.ac_unit_sharp),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
