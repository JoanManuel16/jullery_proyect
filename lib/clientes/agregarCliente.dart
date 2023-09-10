import 'package:flutter/material.dart';

import '../db.dart';
import 'clientesClass.dart';

class AgregarCliene extends StatefulWidget {
  const AgregarCliene({Key? key}) : super(key: key);

  @override
  _ClienteFormState createState() => _ClienteFormState();
}

class _ClienteFormState extends State<AgregarCliene> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _ciController = TextEditingController();
  final TextEditingController _movilController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _notasController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nombreController.dispose();
    _ciController.dispose();
    _movilController.dispose();
    _direccionController.dispose();
    _notasController.dispose();
    super.dispose();
  }

  String? _validateNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'Ingresa solo números';
    }
    return null;
  }

  void _submitFormulario(bool edit, int idCliente) {
    if (_formKey.currentState!.validate()) {
      final String nombre = _nombreController.text;
      final String ci = _ciController.text;
      final String movil = _movilController.text;
      final String direccion = _direccionController.text;
      final String notas = _notasController.text;

      if (edit) {
        DB.updateCliente(ClienteClass(
          idCliente: idCliente,
          nombre: nombre,
          ci: ci,
          movil: movil,
          direccion: direccion,
          notas: notas,
        ));
      } else {
        DB.inserCliente(ClienteClass(
          nombre: nombre,
          ci: ci,
          movil: movil,
          direccion: direccion,
          notas: notas,
        ));
      }
      Navigator.pushReplacementNamed(context, '/clientePrincipal');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    ClienteClass pc =
        ModalRoute.of(context)!.settings.arguments as ClienteClass;
    _nombreController.text = pc.nombre;
    _ciController.text = pc.ci;
    _direccionController.text = pc.direccion;
    _movilController.text = pc.movil;
    _notasController.text = pc.notas!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ciController,
                  decoration: const InputDecoration(
                    labelText: 'CI',
                    hintText: 'Ingresa el CI',
                  ),
                  validator: _validateNumeric,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _movilController,
                  decoration: const InputDecoration(
                    labelText: 'Móvil',
                    hintText: 'Ingresa el número de móvil',
                  ),
                  validator: _validateNumeric,
                ),
                TextFormField(
                  controller: _direccionController,
                  decoration: InputDecoration(labelText: 'Dirección'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _notasController,
                  decoration: InputDecoration(labelText: 'Notas'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _submitFormulario(pc.editar!, pc.idCliente!);
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
