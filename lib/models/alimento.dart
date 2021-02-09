class Alimento {
  String id;
  String nombre;
  String description;
  double carbohidratos;
  double grasas;
  double proteinas;
  List<dynamic> raciones;
  Alimento(
      {this.id,
      this.nombre,
      this.description,
      this.carbohidratos,
      this.grasas,
      this.proteinas,
      this.raciones});
}
