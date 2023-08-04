class CategoriaClass {
  String categoria;
  int id;
  CategoriaClass({this.categoria, this.id});
  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'id_categoria': id,
    };
  }
}
