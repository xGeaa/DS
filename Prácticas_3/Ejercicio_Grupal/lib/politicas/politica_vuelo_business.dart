import 'politica_vuelo.dart';

class PoliticaVueloBusiness extends PoliticaVuelo {
  final double multiplicador = 1.5;

  @override
  double calcular(double precioBase){
    return precioBase * multiplicador;
  }

  @override
  bool operator ==(Object other) => other is PoliticaVueloBusiness;

  @override
  int get hashCode => runtimeType.hashCode;
}