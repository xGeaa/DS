import 'servicio_turistico.dart';


class ServicioPaquete implements ServicioTuristico {

  final String nombre;
  final List<ServicioTuristico> servicios = [];

  ServicioPaquete(this.nombre);

  @override
  double getPrecio(){
    final int tam = servicios.length;
    double precio = 0.0;

    for(int i=0; i<tam; i++){
      precio += servicios[i].getPrecio();
    }

    return precio;
  }

  void agregarServicio(ServicioTuristico servicio){
    servicios.add(servicio);
  }

  void eliminarServicios(ServicioTuristico servicio){
    servicios.remove(servicio);
  }
}