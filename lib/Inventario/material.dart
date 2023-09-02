class MaterialClass {
  int ? id_material;
  String  material;
  double ? precio;
  MaterialClass({required this.material, this.precio,this.id_material});
  Map<String, dynamic> toMap() {
    return {
      'id_material': id_material,
      'material': material,
      'precio': precio,
    };
  }
}
