import 'servicio_turistico.dart';
import '../politicas/politica_vuelo.dart';

class ServicioVuelo extends ServicioTuristico {
  final int id;
  final double precioBase;
  PoliticaVuelo politica;

  ServicioVuelo(this.id, this.precioBase, this.politica);

  @override
  double getPrecio(){
    return politica.calcular(precioBase);
  }

}