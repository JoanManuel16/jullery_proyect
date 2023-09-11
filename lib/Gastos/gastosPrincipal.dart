import 'package:flutter/material.dart';
import 'package:flutter_application_1/Gastos/gastosW.dart';

import '../db.dart';
import 'gastosClass.dart';

class GastosPrincipal extends StatefulWidget {
  const GastosPrincipal({required Key key}) : super(key: key);

  @override
  State<GastosPrincipal> createState() => _GastosPrincipalState();
}

class _GastosPrincipalState extends State<GastosPrincipal> {
  Widget bodyContent = GtastosW();
  DateTime fecha = DateTime.now();
  final costo = TextEditingController();
  List<GastosClass> categorias = [];

  List<String> list = <String>['Día', 'Semana', 'Mes', 'Año'];
  String dropdownValue = '';
  caragrProvedores() async {
    List<GastosClass> aux = await DB.getAllGastos();
    setState(() {
      categorias = aux;
    });
  }
List<GastosClass> filtrarGastosPorFechaActual(List<GastosClass> listaGastos, String opcion) {
  DateTime fechaActual = DateTime.now();
  List<GastosClass> listaFiltrada = [];

  switch (opcion) {
    case 'Día':
      listaFiltrada = listaGastos.where((gasto) {
        DateTime fechaGasto = DateTime.parse(gasto.fecha);
        return fechaGasto.year == fechaActual.year &&
            fechaGasto.month == fechaActual.month &&
            fechaGasto.day == fechaActual.day;
      }).toList();
      break;
    case 'Semana':
      DateTime fechaInicioSemana = fechaActual.subtract(Duration(days: fechaActual.weekday - 1));
      DateTime fechaFinSemana = fechaInicioSemana.add(Duration(days: 6));
      listaFiltrada = listaGastos.where((gasto) {
        DateTime fechaGasto = DateTime.parse(gasto.fecha);
        return fechaGasto.isAfter(fechaInicioSemana.subtract(Duration(days: 1))) &&
            fechaGasto.isBefore(fechaFinSemana.add(Duration(days: 1)));
      }).toList();
      break;
    case 'Mes':
      listaFiltrada = listaGastos.where((gasto) {
        DateTime fechaGasto = DateTime.parse(gasto.fecha);
        return fechaGasto.year == fechaActual.year && fechaGasto.month == fechaActual.month;
      }).toList();
      break;
    case 'Año':
      listaFiltrada = listaGastos.where((gasto) {
        DateTime fechaGasto = DateTime.parse(gasto.fecha);
        return fechaGasto.year == fechaActual.year;
      }).toList();
      break;
    default:
      // Opción no válida
      break;
  }

  return listaFiltrada;
}

  void _mostrarSelectorPeriodo() async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      dropdownValue = list.first;
      return AlertDialog(
        title: Text('Seleccionar período'),
        content: DropdownMenu<String>(
          initialSelection: list.first,
          onSelected: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: () async {
              await caragrProvedores();
              setState(() {
                bodyContent = GtastosW(gastos: filtrarGastosPorFechaActual(categorias,dropdownValue));
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de gastos"),
        actions: [
          IconButton(
            onPressed: () {
              _mostrarSelectorPeriodo();
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/crearDrop");
        },
        child: Icon(Icons.add),
      ),
      body: bodyContent,
    );
  }
}
