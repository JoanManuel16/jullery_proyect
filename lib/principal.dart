import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Principal'),
      ),
      body: Container(
        child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
  children: [
    Expanded(
      child: Container(height: 100,width: 100,child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context,"/provedorPrincipal");
        },
        child: Center(
          child: Column(children: [
            Icon(Icons.person_add_alt_rounded,size: 50,),
            SizedBox(height: 10,),
            Text('Provedores')
          ],),
        )
      ),)
    ),
    SizedBox(width: 20,),
    Expanded(
      child: Container(height: 100,width: 100,child: ElevatedButton(
        onPressed: () {
        },
        child: Icon(Icons.ac_unit_sharp),
      ),)
    ),
  ],
),
 SizedBox(height: 20,),
 Row(
  children: [
    Expanded(
      child: Container(height: 100,width: 100,child: ElevatedButton(
        onPressed: () {
        },
        child: Icon(Icons.ac_unit_sharp),
      ),)
    ),
    SizedBox(width: 20,),
    Expanded(
      child: Container(height: 100,width: 100,child: ElevatedButton(
        onPressed: () {
        },
        child: Icon(Icons.ac_unit_sharp),
      ),)
    ),
  ],
),
SizedBox(height: 20,),
 Row(
  children: [
    Expanded(
      child: Container(height: 100,width: 100,child: ElevatedButton(
        onPressed: () {
        },
        child: Icon(Icons.ac_unit_sharp),
      ),)
    ),
    SizedBox(width: 20,),
    Expanded(
      child: Container(height: 100,width: 100,child: ElevatedButton(
        onPressed: () {
        },
        child: Icon(Icons.ac_unit_sharp),
      ),)
    ),
  ],
),
 SizedBox(height: 20,),
 Center(
    child: Expanded(child: Container(
      height: 150,width: 400,child: ElevatedButton(
        onPressed: () {
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