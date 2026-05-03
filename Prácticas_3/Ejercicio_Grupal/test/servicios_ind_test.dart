import 'package:flutter_test/flutter_test.dart';
import 'package:practica_3/services/servicio_vuelo.dart';
import 'package:practica_3/services/servicio_hotel.dart';
import 'package:practica_3/politicas/politica_vuelo_low_cost.dart';
import 'package:practica_3/politicas/politica_hotel_solo_alojamiento.dart';

void main() {

  group('Grupo Servicios Individuales (Hojas)', () {

    test('El constructor de Vuelo lanza una excepción ante un precio base negativo', () {
      expect(
            () => ServicioVuelo(101, -10.0, PoliticaVueloLowCost()),
        throwsA(isA<AssertionError>()),
      );
    });

    test('El constructor de Hotel impide la creación de estancias con cero o menos noches', () {
      expect(
            () => ServicioHotel("Hotel Playa", 100.0, 0, PoliticaHotelSoloAlojamiento()),
        throwsA(isA<AssertionError>()),
      );
    });

    test('El método getPrecio() de Vuelo delega el cálculo en su política asignada', () {
      final vuelo = ServicioVuelo(102, 100.0, PoliticaVueloLowCost());

      expect(vuelo.getPrecio(), equals(120.0));
    });

    test('El método getPrecio() de Hotel retorna el valor procesado por su política de régimen', () {
      final hotel = ServicioHotel("Hotel Montaña", 50.0, 3, PoliticaHotelSoloAlojamiento());

      expect(hotel.getPrecio(), equals(150.0));
    });

  });
}