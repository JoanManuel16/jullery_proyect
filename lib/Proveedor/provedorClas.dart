class ProvedorClass {
  String nombre;
  String Ci;
  String movil;
  String direccion;
  String notas;
  bool edicion;
  ProvedorClass(
      {required this.nombre,
      required this.Ci,
      required this.movil,
      required this.direccion,
      required this.notas,
      required this.edicion});
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'Ci': Ci,
      'movil': movil,
      'direccion': direccion,
      'notas': notas,
      'edicion': edicion
    };
  }

  String getNombre() {
    return nombre;
  }

  String getCi() {
    return Ci;
  }

  String getMovil() {
    return movil;
  }

  String getDireccion() {
    return direccion;
  }

  String getNotas() {
    return notas;
  }

  bool getEdicion() {
    return edicion;
  }
}
