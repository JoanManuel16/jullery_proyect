class GastosClass {
  String fecha;
  int importe;
  String categoria;
  String nombre;
  GastosClass({this.fecha, this.importe, this.categoria, this.nombre});
  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha,
      'importe': importe,
      'categoria': categoria,
      'nombre': nombre,
    };
  }
}
