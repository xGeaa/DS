import 'package:flutter_test/flutter_test.dart';
// RECUERDA: Ajusta estos imports a las rutas reales de tus archivos .dart
import 'package:practica_3/politicas/politica_vuelo_low_cost.dart';
import 'package:practica_3/politicas/politica_vuelo_business.dart';
import 'package:practica_3/politicas/politica_hotel_solo_alojamiento.dart';
import 'package:practica_3/politicas/politica_hotel_todo_incluido.dart';

void main() {
  group('Grupo Políticas de Tarifación', () {

    test('TarifaLowCost añade su recargo de gestión constante al precio base', () {
      final politica = PoliticaVueloLowCost();
      const precioBase = 100.0;
      final resultado = politica.calcular(precioBase);
      expect(resultado, equals(120.0));
    });

    test('TarifaBusiness aplica su multiplicador interno de clase superior correctamente', () {
      final politica = PoliticaVueloBusiness();
      const precioBase = 100.0;
      final resultado = politica.calcular(precioBase);
      expect(resultado, equals(150.0));
    });

    test('RegimenSoloAlojamiento calcula el producto exacto de noches por precio', () {
      final politica = PoliticaHotelSoloAlojamiento();
      const precioNoche = 80.0;
      const noches = 3;
      final resultado = politica.calcular(precioNoche, noches);
      expect(resultado, equals(240.0));
    });

    test('RegimenTodoIncluido incorpora su suplemento diario interno al coste de la estancia', () {
      final politica = PoliticaHotelTodoIncluido();
      const precioNoche = 80.0;
      const noches = 2;
      final resultado = politica.calcular(precioNoche, noches);
      expect(resultado, equals(260.0));
    });

  });
}