class InventarioClass {
  int id_inventario;
  String tipo_joya;
  int cantidad;
  double gramaje;
  String material;
  double precio_individual;
  double precio_total;
  InventarioClass(
      {required this.id_inventario,
      required this.tipo_joya,
      required this.cantidad,
      required this.gramaje,
      required this.material,
      required this.precio_individual,
      required this.precio_total});
  Map<String, dynamic> toMap() {
    return {
      'id_inventario': id_inventario,
      'tipo_joya': tipo_joya,
      'cantidad': cantidad,
      'gramaje': gramaje,
      'material': material,
      'precio_individual': precio_individual,
      'precio_total': precio_total
    };
  }
}
