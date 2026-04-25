import 'package:flutter/material.dart';
import '/services/servicio_turistico.dart';
import '/services/servicio_paquete.dart';
import '/services/servicio_vuelo.dart';
import '/services/servicio_hotel.dart';

import '/politicas/politica_vuelo_low_cost.dart';
import '/politicas/politica_vuelo_business.dart';
import '/politicas/politica_hotel_solo_alojamiento.dart';
import '/politicas/politica_hotel_todo_incluido.dart';
void main() {
  runApp(const MaterialApp(home: ReservasScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const ReservasScreen());
  }
}

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});
  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  final ServicioPaquete _paqueteRaiz = ServicioPaquete("Mis Vacaciones");

  void _abrirDialogoAgregar() {
    String tipo = 'Vuelo';
    dynamic politica = PoliticaVueloLowCost();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Nuevo Servicio"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: tipo,
                  items: ['Vuelo', 'Hotel'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setDialogState(() {
                    tipo = val!;
                    politica = (tipo == 'Vuelo' ? PoliticaVueloLowCost() : PoliticaHotelSoloAlojamiento());
                  }),
                ),
                const SizedBox(height: 10),
                DropdownButton<dynamic>(
                  value: politica,
                  isExpanded: true,
                  items: tipo == 'Vuelo'
                      ? [
                    DropdownMenuItem(value: PoliticaVueloLowCost(), child: const Text("Low Cost")),
                    DropdownMenuItem(value: PoliticaVueloBusiness(), child: const Text("Business")),
                  ]
                      : [
                    DropdownMenuItem(value: PoliticaHotelSoloAlojamiento(), child: const Text("Solo Alojamiento")),
                    DropdownMenuItem(value: PoliticaHotelTodoIncluido(), child: const Text("Todo Incluido")),
                  ],
                  onChanged: (val) => setDialogState(() => politica = val!),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (tipo == 'Vuelo') {
                      _paqueteRaiz.servicios.add(ServicioVuelo(DateTime.now().millisecond, 100.0, politica));
                    } else {
                      _paqueteRaiz.servicios.add(ServicioHotel("Hotel-${DateTime.now().millisecond}", 50.0, 2, politica));
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text("Añadir"),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestión de Paquetes")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _paqueteRaiz.servicios.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final item = _paqueteRaiz.servicios[i];
                return ListTile(
                  leading: Icon(item is ServicioVuelo ? Icons.flight : Icons.hotel),
                  title: Text(item is ServicioVuelo ? "Vuelo: ${item.id}" : "Hotel: ${(item as ServicioHotel).nombre}"),
                  trailing: Text("${item.getPrecio().toStringAsFixed(2)} €"),
                );
              },
            ),
          ),
          // Footer Integrado (Aquí va el precio y el botón, no se solapan)
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total:", style: TextStyle(fontSize: 14)),
                    Text("${_paqueteRaiz.getPrecio().toStringAsFixed(2)} €",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _abrirDialogoAgregar,
                  icon: const Icon(Icons.add),
                  label: const Text("Añadir"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}