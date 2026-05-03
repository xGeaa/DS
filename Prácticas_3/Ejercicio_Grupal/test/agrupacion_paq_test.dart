import 'package:flutter_test/flutter_test.dart';
import 'package:practica_3/services/servicio_vuelo.dart';
import 'package:practica_3/services/servicio_hotel.dart';
import 'package:practica_3/services/servicio_paquete.dart';
import 'package:practica_3/politicas/politica_vuelo_low_cost.dart';
import 'package:practica_3/politicas/politica_vuelo_business.dart';
import 'package:practica_3/politicas/politica_hotel_solo_alojamiento.dart';

void main() {
  group('Grupo Agrupación de Paquetes', () {

    test('Un Paquete recién instanciado sin servicios devuelve un precio total de cero', () {
      final paqueteVacio = ServicioPaquete("Pack Vacío");
      expect(paqueteVacio.getPrecio(), equals(0.0));
    });

    test('El método getPrecio() de Paquete realiza la suma aritmética de todos sus componentes directos', () {
      final paquete = ServicioPaquete("Pack Simple");
      final vuelo = ServicioVuelo(1, 100.0, PoliticaVueloLowCost());
      final hotel = ServicioHotel("Hotel", 50.0, 2, PoliticaHotelSoloAlojamiento());
      paquete.agregarServicio(vuelo);
      paquete.agregarServicio(hotel);

      expect(paquete.getPrecio(), equals(220.0));
    });

    test('La estructura recursiva permite que un paquete raíz sume correctamente el importe de paquetes anidados', () {
      final paqueteRaiz = ServicioPaquete("Gran Viaje");
      final paqueteHijo = ServicioPaquete("SubPack Vuelo+Hotel");
      final vuelo = ServicioVuelo(1, 100.0, PoliticaVueloLowCost());
      final hotel = ServicioHotel("Hotel", 50.0, 2, PoliticaHotelSoloAlojamiento());

      paqueteHijo.agregarServicio(vuelo);
      paqueteHijo.agregarServicio(hotel);
      paqueteRaiz.agregarServicio(paqueteHijo);
      paqueteRaiz.agregarServicio(ServicioVuelo(2, 50.0, PoliticaVueloLowCost()));
      expect(paqueteRaiz.getPrecio(), equals(290.0));
    });

    test('La modificación de la política de un servicio contenido actualiza el precio total del paquete raíz', () {
      final paqueteRaiz = ServicioPaquete("Pack Dinámico");
      final vuelo = ServicioVuelo(1, 100.0, PoliticaVueloBusiness());

      paqueteRaiz.agregarServicio(vuelo);
      expect(paqueteRaiz.getPrecio(), equals(150.0));

      vuelo.politica = PoliticaVueloLowCost();
      expect(paqueteRaiz.getPrecio(), equals(120.0));
    });
  });
}