import 'servicio_turistico.dart';
import '../politicas/politica_hotel.dart';

class ServicioHotel extends ServicioTuristico{
  final String nombre;
  final double precioNoche;
  final int noches;
  PoliticaHotel politica;

  ServicioHotel(this.nombre, this.precioNoche, this.noches, this.politica) : assert(noches > 0, 'Las noches deben ser más de cero');

  @override
  double getPrecio(){
    return politica.calcular(precioNoche, noches);
  }
}