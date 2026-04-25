import 'politica_hotel.dart';

class PoliticaHotelTodoIncluido extends PoliticaHotel {
  final double suplemento = 50;


  @override
  double calcular(double precioNoche, int noches){
    return (precioNoche + suplemento) * noches;
  }

  @override
  bool operator ==(Object other) => other is PoliticaHotelTodoIncluido;

  @override
  int get hashCode => runtimeType.hashCode;
}