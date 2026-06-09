class Contacto {
  static int contador = 0;
  late int id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String? domicilio;
  final String email;

  Contacto({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    this.domicilio,
    required this.email,
  });

  Contacto.id({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    this.domicilio,
    required this.email,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Contacto && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Contacto copyWith({
    String? nombre,
    String? apellido,
    String? telefono,
    String? domicilio,
    String? email,
  }) => Contacto(
    nombre: this.nombre,
    apellido: this.apellido,
    telefono: this.telefono,
    domicilio: this.domicilio,
    email: this.email
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "apellido": apellido,
    "telefono": telefono,
    "domicilio": domicilio,
    "email": email
  };

  @override
  String toString() {
    return '{id: $id,nombre: $nombre, apellido: $apellido, telefono: $telefono, domicilio: $domicilio, email: $email}  \n';
  }
}
