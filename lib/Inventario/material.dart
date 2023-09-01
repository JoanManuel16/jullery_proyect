class MaterialClass {
  int id_material;
  String material;
  double precio;
  MaterialClass({this.material, this.precio});
  Map<String, dynamic> toMap() {
    return {
      'id_material': id_material,
      'material': material,
      'precio': precio,
    };
  }
}
