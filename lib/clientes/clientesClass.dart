import '../Inventario/invantarioClass.dart';

class ClienteClass {
  int? idCliente;
  String nombre;
  String ci;
  String movil;
  String direccion;
  String? notas;
  bool ?editar;
  List<InventarioClass>? inventarioCliente;
  ClienteClass(
      {this.idCliente,
      this.editar,
      required this.ci,
      required this.direccion,
      this.inventarioCliente,
      required this.movil,
      required this.nombre,
      this.notas});
      Map<String, dynamic> toMap() {
    return {
      'idCliente': idCliente,
      'nombre': nombre,
      'ci': ci,
      'movil': movil,
      'direccion': direccion,
      'notas': notas,
    };
  }
}
