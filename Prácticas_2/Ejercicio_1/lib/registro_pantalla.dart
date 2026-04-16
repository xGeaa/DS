import 'package:flutter/material.dart';
import 'auth_request.dart';
import 'filter_manager.dart';

class RegistroPantalla extends StatefulWidget{
  const RegistroPantalla({super.key});

  @override
  State<RegistroPantalla> createState() => RegistroPantallaState();
}

class RegistroPantallaState extends State<RegistroPantalla> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final manager = FilterManager();

  void validarYregistrar() {
    final peticion = AuthRequest(emailController.text, passwordController.text);
    final error = manager.procesarRegistro(peticion);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if(error!=null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error"), backgroundColor: Colors.red),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registro Exitoso"), backgroundColor: Colors.green,),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Registro Seguro")),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: validarYregistrar, child: const Text("Registrarse"))
          ],
        )
      ),
    );
  }
}