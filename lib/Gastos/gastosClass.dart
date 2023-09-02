class GastosClass {
  String fecha;
  int importe;
  String categoria;
  String nombre;
  GastosClass({required this.fecha, required this.importe,required this.categoria,required this.nombre});
  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha,
      'importe': importe,
      'categoria': categoria,
      'nombre': nombre,
    };
  }
}
