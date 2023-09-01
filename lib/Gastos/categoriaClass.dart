class CategoriaClass {
  String categoria;
  int id;
  CategoriaClass({required this.categoria, required this.id});
  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'id_categoria': id,
    };
  }
}
