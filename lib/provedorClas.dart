class ProvedorClass {
  String nombre;
  String Ci;
  int movil;
  String direccion;
  String notas;
  ProvedorClass({this.nombre, this.Ci, this.movil, this.direccion, this.notas});
  Map<String, dynamic> toMap() {
    return {'nombre': nombre, 'Ci': Ci, 'movil': movil,'direccion':direccion,'notas':notas};
  }
}
