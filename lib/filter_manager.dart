import 'auth_request.dart';
import 'filtros.dart';

class FilterManager {
  final List<Filtro> filtros = [];

  FilterManager() {
    filtros.add(FiltroEmailVacio());
    filtros.add(FiltroEmailExistente());
    filtros.add(FiltroFormatoEmail());
    filtros.add(FiltroSeguridadPassword());
  }

  String? procesarRegistro(AuthRequest request){
    for(var filtro in filtros){
      String? error = filtro.execute(request);
      if(error != null){
        return error;
      }
    }
    return null;
  }
}