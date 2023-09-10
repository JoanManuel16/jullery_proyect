import 'package:flutter_application_1/Inventario/invantarioClass.dart';

class ClientesInventarioClass extends InventarioClass{
  int ? idClienteInventario;
  int ? idCliente;
ClientesInventarioClass({this.idClienteInventario,this.idCliente,required String tipo_joya, required int cantidad, required double gramaje, required String material, required double precio_individual, required double precio_total}) : super(tipo_joya: tipo_joya, cantidad: cantidad, gramaje: gramaje, material: material, precio_individual: precio_individual, precio_total: precio_total);
@override
  Map<String, dynamic> toMap() {
    return {
      'idClienteInventario': idClienteInventario,
      'idCliente': idCliente,
      'tipo_joya': tipo_joya,
      'cantidad': cantidad,
      'gramaje': gramaje,
      'material': material,
      'precio_individual': precio_individual,
      'precio_total': precio_total
    };
  }
  
}