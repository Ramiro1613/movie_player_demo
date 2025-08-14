class User {
  final String idDispositivo;
  final String nombre;
  final DateTime fechaAlta;

  User({
    required this.idDispositivo,
    required this.nombre,
    required this.fechaAlta,
  });

  Map<String, dynamic> toJson() {
    return {
      'idDispositivo': idDispositivo,
      'nombre': nombre,
      'fechaAlta': fechaAlta.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idDispositivo: json['idDispositivo'] ?? '',
      nombre: json['nombre'] ?? '',
      fechaAlta: DateTime.parse(json['fechaAlta']),
    );
  }
}
