class Tipo_joya {
  int id_tipo;
  String tipo;
  Tipo_joya({required this.id_tipo, required this.tipo});
  Map<String, dynamic> toMap() {
    return {
      'id_joya': id_tipo,
      'tipo': tipo,
    };
  }
}
