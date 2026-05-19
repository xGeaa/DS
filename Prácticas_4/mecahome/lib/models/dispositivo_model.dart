class Dispositivo {
  final int id;
  final String nombre;
  final String tipo;
  final String marca;
  final String estado;
  final double? temperaturaActual;
  double? temperaturaDeseada;
  final String? modoClima;

  Dispositivo({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.marca,
    required this.estado,
    this.temperaturaActual,
    this.temperaturaDeseada,
    this.modoClima,
  });

  // Constructor para transformar el JSON que viene de Rails a un Objeto de Flutter
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
    );
  }
}