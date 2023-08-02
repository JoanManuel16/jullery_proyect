class ProvedorClass {
  String nombre;
  String Ci;
  String movil;
  String direccion;
  String notas;
  bool edicion;
  ProvedorClass({this.nombre, this.Ci, this.movil, this.direccion, this.notas,this.edicion});
  Map<String, dynamic> toMap() {
    return {'nombre': nombre, 'Ci': Ci, 'movil': movil,'direccion':direccion,'notas':notas,'edicion':edicion};
  }
}
