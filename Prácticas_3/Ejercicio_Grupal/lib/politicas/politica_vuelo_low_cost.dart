import 'politica_vuelo.dart';

class PoliticaVueloLowCost extends PoliticaVuelo {
  final double recargo = 20;


  @override
  double calcular(double precioBase){
    return precioBase + recargo;
  }

  @override
  bool operator ==(Object other) => other is PoliticaVueloLowCost;

  @override
  int get hashCode => runtimeType.hashCode;
}