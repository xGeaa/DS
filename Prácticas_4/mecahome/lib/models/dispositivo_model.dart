class Dispositivo {
  final int id;
  final String nombre;
  final String tipo;
  final String marca;
   String? estado;
   double? temperaturaActual;
  double? temperaturaDeseada;
  final String? modoClima;
  int? luminosidad;

  Dispositivo({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.marca,
    required this.estado,
    this.temperaturaActual,
    this.temperaturaDeseada,
    this.modoClima,
    this.luminosidad
  });

  factory Dispositivo.fromJson(Map<String, dynamic> json) {
    return Dispositivo(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      marca: json['marca'],
      estado: json['estado'],
      temperaturaActual: json['temperatura_actual']?.toDouble(),
      temperaturaDeseada: json['temperatura_deseada']?.toDouble(),
      modoClima: json['modo_clima'],
      luminosidad: json['luminosidad'],
    );
  }
}