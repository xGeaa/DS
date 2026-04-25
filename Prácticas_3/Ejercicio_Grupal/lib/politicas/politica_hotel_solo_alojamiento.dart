import 'politica_hotel.dart';

class PoliticaHotelSoloAlojamiento extends PoliticaHotel {
  @override
  double calcular(double precioNoche, int noches){
    return precioNoche * noches;
  }

  @override
  bool operator ==(Object other) => other is PoliticaHotelSoloAlojamiento;

  @override
  int get hashCode => runtimeType.hashCode;
}