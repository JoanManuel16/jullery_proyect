class InventarioClass {
  int id_inventario;
  String tipo_joya;
  int cantidad;
  double gramaje;
  String material;
  double precio_individual;
  double precio_total;
  InventarioClass(
      {this.id_inventario,
      this.tipo_joya,
      this.cantidad,
      this.gramaje,
      this.material,
      this.precio_individual,
      this.precio_total});
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
