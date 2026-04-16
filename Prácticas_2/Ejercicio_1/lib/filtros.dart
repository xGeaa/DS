import 'auth_request.dart';

abstract class Filtro {
  String? execute(AuthRequest request);
}

// Mantenimiento Perfectivo, se comprueba que el campo "email" no esta vacio

class FiltroEmailVacio implements Filtro {
  @override
  String? execute(AuthRequest request) {
    if(request.email.trim().isEmpty){
      return "El email no puede estar vacio";
    } else{
      return null;
    }
  }
}

class FiltroFormatoEmail implements Filtro {
  @override
  String? execute(AuthRequest request) {
    final expresion = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$');
    if(!expresion.hasMatch(request.email)){
      return "Formato de email invalido";
    } else {
      return null;
    }
  }
}

//Mantenimiento perfectivo/preventivo, se comprueba si el email esta ya registrado

class FiltroEmailExistente implements Filtro {
  final List<String> usuariosRegistrados = [ "test@gmail.com" , "ejemplo@ugr.es" ];

  @override
  String? execute(AuthRequest request) {
    if(usuariosRegistrados.contains(request.email.toLowerCase())) {
      return "El correo ya esta registrado";
    }
  }
}

class FiltroSeguridadPassword implements Filtro {
   @override
  String? execute(AuthRequest request) {
     if(request.password.length < 8) return "La contraseña ha de tener al menos 8 caracteres";
     if(!request.password.contains(RegExp(r'[A-Z]'))) return "La contraseña ha de contener al menos 1 mayuscula";
     if(!request.password.contains(RegExp(r'[0-9]'))) return "La contraseña ha de contener al menos 1 digito";
     return null;
  }
}