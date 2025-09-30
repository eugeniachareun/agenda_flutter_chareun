enum Genero {
  femenino,
  masculino
}

class Contacto {
  static int contador = 0;
  late int id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String domicilio;
  final Genero genero;

  Contacto({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.domicilio,
    required this.genero
  }) {
    contador++;
    id = contador;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Contacto && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Contacto copyWith({String? nombre, String? apellido, String? telefono, String? domicilio, Genero? genero}) =>
      Contacto(nombre: this.nombre, apellido: this.apellido, telefono: this.telefono, domicilio: this.domicilio, genero: this.genero);

  @override
  String toString() {
    return '{id: $id,nombre: $nombre, apellido: $apellido, telefono: $telefono, domicilio: $domicilio, genero: $genero}  \n';
  }
}
