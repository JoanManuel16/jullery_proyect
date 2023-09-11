import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../Gastos/gastosClass.dart';
import '../db.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

class Reportes extends StatefulWidget {
  Reportes({Key? key}) : super(key: key);

  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  List<String> list = <String>['Día', 'Semana', 'Mes', 'Año'];
  List<GastosClass> categorias = [];
  String dropdownValue = '';

  caragrProvedores() async {
    List<GastosClass> aux = await DB.getAllGastos();
    setState(() {
      categorias = aux;
    });
  }

  List<GastosClass> filtrarGastosPorFechaActual(
      List<GastosClass> listaGastos, String opcion) {
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
        DateTime fechaInicioSemana =
            fechaActual.subtract(Duration(days: fechaActual.weekday - 1));
        DateTime fechaFinSemana = fechaInicioSemana.add(Duration(days: 6));
        listaFiltrada = listaGastos.where((gasto) {
          DateTime fechaGasto = DateTime.parse(gasto.fecha);
          return fechaGasto
                  .isAfter(fechaInicioSemana.subtract(Duration(days: 1))) &&
              fechaGasto.isBefore(fechaFinSemana.add(Duration(days: 1)));
        }).toList();
        break;
      case 'Mes':
        listaFiltrada = listaGastos.where((gasto) {
          DateTime fechaGasto = DateTime.parse(gasto.fecha);
          return fechaGasto.year == fechaActual.year &&
              fechaGasto.month == fechaActual.month;
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
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
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
                  generarYGuardarPDF(
                      filtrarGastosPorFechaActual(categorias, dropdownValue));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> generarYGuardarPDF(List<GastosClass> listaGastos) async {
    final pdf = pw.Document();

    // Crear tabla
    final headers = ['Fecha', 'Importe', 'Categoría', 'Nombre'];
    final data = listaGastos
        .map((gasto) => [
              gasto.fecha,
              gasto.importe.toString(),
              gasto.categoria,
              gasto.nombre
            ])
        .toList();

    // Calcular el total de los gastos
    double total = listaGastos.fold(
        0, (previousValue, gasto) => previousValue + gasto.importe);

    // Agregar el campo de total a la tabla
    final totalRow = ['Total', total.toString(), '', ''];
    data.add(totalRow);

    final table = pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: pw.TableBorder.all(),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      cellAlignment: pw.Alignment.center,
    );

    // Agregar tabla al PDF
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Padding(
        padding: pw.EdgeInsets.all(16),
        child: pw.Column(children: [
          pw.Text('Reporte de Gastos',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          table,
        ]),
      );
    }));

    // Obtener la ruta de la carpeta de documentos
    String documentsPath = '/storage/emulated/0/Download/';
    final uuid = Uuid();
    final uuidString = uuid.v4();
    final path = '$documentsPath/reporte_gastos_$uuidString.pdf';

    // Guardar el PDF en la carpeta de documentos
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor de los botones
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
                height: 16), // Separador al inicio con un espacio vertical
            const Text(
              'Reportes de gastos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(), // Separador debajo del texto
            ElevatedButton(
              onPressed: () {
                _mostrarSelectorPeriodo();
              },
              child: const Text('Botón 1'),
            ),
            const SizedBox(height: 8), // Espacio vertical entre los botones
            const Divider(), // Separador al final de los botones
          ],
        ),
      ),
    );
  }
}