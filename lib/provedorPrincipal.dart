import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provedorClas.dart';
import 'package:flutter_application_1/provedorW.dart';

class PorvedorPrinciapl extends StatelessWidget {
  const PorvedorPrinciapl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Listado de provedores"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/provedor",
              arguments: ProvedorClass(edicion: false)
            );
          },
          child: Icon(Icons.add)),
          body: PorvedorW(),
    
    )
    
    );
  }
}
