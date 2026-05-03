import 'servicio_turistico.dart';
import '../politicas/politica_vuelo.dart';

class ServicioVuelo extends ServicioTuristico {
  final int id;
  final double precioBase;
  PoliticaVuelo politica;

  ServicioVuelo(this.id, this.precioBase, this.politica) : assert(precioBase >= 0, 'El precio no puede ser negativo');

  @override
  double getPrecio(){
    return politica.calcular(precioBase);
  }

}