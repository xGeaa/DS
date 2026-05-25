import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/dispositivo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Dispositivo>> _futureDispositivos;

  @override
  void initState() {
    super.initState();
    _cargarDispositivos();
  }

  void _cargarDispositivos() {
    setState(() {
      _futureDispositivos = _apiService.getDispositivos();
    });
  }

  // Operación UPDATE del CRUD: Alternar encendido/apagado
  void _alternarEstado(Dispositivo dispositivo) async {
    String nuevoEstado = dispositivo.estado == 'on' ? 'off' : 'on';
    bool exito = await _apiService.actualizarDispositivo(
        dispositivo.id,
        {'estado': nuevoEstado}
    );
    if (exito) {
      _cargarDispositivos();
    }
  }

  // Operación DELETE del CRUD
  void _eliminarDispositivo(int id) async {
    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Borrar dispositivo?'),
        content: const Text('Esta acción eliminará el dispositivo de forma permanente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      bool exito = await _apiService.borrarDispositivo(id);
      if (exito) {
        _cargarDispositivos();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dispositivo eliminado con éxito')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar el dispositivo')),
        );
      }
    }
  }

  // Operación CREATE del CRUD
  void _mostrarFormularioCrear() {
    final nombreController = TextEditingController();
    String tipoSeleccionado = 'iluminacion';
    String marcaSeleccionada = 'philips';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20, left: 20, right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Añadir Nuevo Dispositivo 🛠️', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del dispositivo', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: tipoSeleccionado,
                decoration: const InputDecoration(labelText: 'Tipo de Dispositivo', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'iluminacion', child: Text('Iluminación 💡')),
                  DropdownMenuItem(value: 'climatizacion', child: Text('Climatización ❄️')),
                  DropdownMenuItem(value: 'energia', child: Text('Enchufe / Energía 🔌')),
                  DropdownMenuItem(value: 'persiana', child: Text('Persiana 🪟')),
                ],
                onChanged: (val) => setModalState(() => tipoSeleccionado = val!),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: marcaSeleccionada,
                decoration: const InputDecoration(labelText: 'Marca', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'philips', child: Text('Philips')),
                  DropdownMenuItem(value: 'xiaomi', child: Text('Xiaomi')),
                  DropdownMenuItem(value: 'nest', child: Text('Nest (Google)')),
                ],
                onChanged: (val) => setModalState(() => marcaSeleccionada = val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15)),
                onPressed: () async {
                  if (nombreController.text.isNotEmpty) {
                    Map<String, dynamic> nuevoDispositivo = {
                      'nombre': nombreController.text,
                      'tipo': tipoSeleccionado,
                      'marca': marcaSeleccionada,
                      'estado': 'off',
                    };


                    final listaActual = await _futureDispositivos;


                    if (tipoSeleccionado == 'climatizacion') {
                      final ultimoAire = listaActual.firstWhere(
                            (d) => d.tipo == 'climatizacion',
                        orElse: () => Dispositivo(id: 0, nombre: '', tipo: '', marca: '', estado: ''),
                      );

                      if (ultimoAire.id != 0) {
                        nuevoDispositivo['temperatura_actual'] = ultimoAire.temperaturaActual ?? 24.0;
                        nuevoDispositivo['temperatura_deseada'] = ultimoAire.temperaturaDeseada ?? 21.0;
                        nuevoDispositivo['modo_clima'] = ultimoAire.modoClima ?? 'eco';
                        nuevoDispositivo['luminosidad'] = ultimoAire.luminosidad ?? 50;
                        nuevoDispositivo['estado'] = ultimoAire.estado;
                      } else {
                        nuevoDispositivo['temperatura_actual'] = 24.0;
                        nuevoDispositivo['temperatura_deseada'] = 21.0;
                        nuevoDispositivo['modo_clima'] = 'eco';
                        nuevoDispositivo['luminosidad'] = 50;
                      }
                    }

                    // 3. Si es Iluminación, sincronizamos la luminosidad y el estado con las otras bombillas
                    else if (tipoSeleccionado == 'iluminacion') {
                      final ultimaBombilla = listaActual.firstWhere(
                            (d) => d.tipo == 'iluminacion',
                        orElse: () => Dispositivo(id: 0, nombre: '', tipo: '', marca: '', estado: ''),
                      );

                      if (ultimaBombilla.id != 0) {

                        nuevoDispositivo['luminosidad'] = ultimaBombilla.luminosidad ?? 50;
                        nuevoDispositivo['estado'] = ultimaBombilla.estado;
                      } else {
                        nuevoDispositivo['luminosidad'] = 50;
                        nuevoDispositivo['estado'] = 'off';
                      }
                    }
                    else if (tipoSeleccionado == 'persiana') {
                      final ultimaPersiana = listaActual.firstWhere(
                            (d) => d.tipo == 'persiana',
                        orElse: () => Dispositivo(id: 0, nombre: '', tipo: '', marca: '', estado: ''),
                      );

                      if (ultimaPersiana.id != 0) {
                        nuevoDispositivo['luminosidad'] = ultimaPersiana.luminosidad ?? 50;
                        nuevoDispositivo['estado'] = ultimaPersiana.estado;
                      } else {
                        nuevoDispositivo['luminosidad'] = 50;
                        nuevoDispositivo['estado'] = 'on'; // Nace abierta por defecto si es la primera
                      }
                    }

                    bool exito = await _apiService.crearDispositivo(nuevoDispositivo);
                    if (exito) {
                      Navigator.pop(context);
                      _cargarDispositivos();
                    }
                  }
                },
                child: const Text('Guardar Dispositivo'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Cambiar la temperatura deseada (Strategy target)
  Future<Dispositivo?> _cambiarTemperaturaDeseada(Dispositivo disp, double cambio) async {
    double nuevaTemp = (disp.temperaturaDeseada ?? 22.0) + cambio;
    bool exito = await _apiService.actualizarDispositivo(disp.id, {
      'temperatura_deseada': nuevaTemp
    });

    if (exito) {
      _cargarDispositivos();
      try {
        disp.temperaturaDeseada = nuevaTemp;
        return disp;
      } catch (e) {
        disp.temperaturaDeseada = nuevaTemp;
        return disp;
      }
    }
    return null;
  }

  // Cambiar la estrategia en caliente (Modo Clima)
  void _cambiarModoClima(Dispositivo disp, String nuevoModo) async {
    bool exito = await _apiService.actualizarDispositivo(disp.id, {
      'modo_clima': nuevoModo
    });
    if (exito) _cargarDispositivos();
  }


  void _mostrarFormularioEntornoGlobal() {
    final tempController = TextEditingController(text: '24.0');
    final lumController = TextEditingController(text: '50');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Simular Entorno Global ☀️'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Aplica a toda la casa:', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 10),
            TextField(
              controller: tempController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Temperatura Actual (°C)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: lumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Luminosidad Global (0-100)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () async {
              double nuevaTemp = double.tryParse(tempController.text) ?? 24.0;
              int nuevaLum = int.tryParse(lumController.text) ?? 50;

              // Recuperamos todos los dispositivos actuales
              final dispositivos = await _futureDispositivos;

              // Actualizamos todos los dispositivos en bucle para mandar el entorno global
              for (var disp in dispositivos) {
                await _apiService.actualizarDispositivo(disp.id, {
                  'temperatura_actual': nuevaTemp,
                  'luminosidad': nuevaLum,
                  // Le mandamos estado 'on' a los climas para que Rails haga su magia de evaluación
                  'estado': disp.tipo == 'climatizacion' ? 'on' : disp.estado
                });
              }

              Navigator.pop(context); // Cierra el diálogo
              _cargarDispositivos();  // Recarga la pantalla
            },
            child: const Text('Aplicar a Todo', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  // Panel flotante con los controles del Aire Acondicionado
  void _mostrarControlesClima(Dispositivo dispositivo) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Control de ${dispositivo.nombre} ❄️', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Fila para controlar la temperatura (SIN EL SOL)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 36, color: Colors.blue),
                    onPressed: () async {
                      Dispositivo? actualizado = await _cambiarTemperaturaDeseada(dispositivo, -0.5);
                      if (actualizado != null) {
                        setModalState(() {
                          dispositivo = actualizado;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 15),
                  Text(
                    '${dispositivo.temperaturaDeseada}°C',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 36, color: Colors.red),
                    onPressed: () async {
                      Dispositivo? actualizado = await _cambiarTemperaturaDeseada(dispositivo, 0.5);
                      if (actualizado != null) {
                        setModalState(() {
                          dispositivo = actualizado;
                        });
                      }
                    },
                  ),
                ],
              ),
              const Text('Temperatura Deseada', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 25),

              // Selector de Estrategia (Modo)
              const Text('Estrategia de Climatización (Patrón Strategy):', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'eco', label: Text('ECO 🌱')),
                  ButtonSegment(value: 'confort', label: Text('CONFORT 🏠')),
                  ButtonSegment(value: 'vacaciones', label: Text('VACACIONES 🏖️')),
                ],
                selected: {dispositivo.modoClima?.toLowerCase() ?? 'eco'},
                onSelectionChanged: (Set<String> nuevoModo) {
                  _cambiarModoClima(dispositivo, nuevoModo.first);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MecaHome  🏠', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _cargarDispositivos,
          )
        ],
      ),
      body: FutureBuilder<List<Dispositivo>>(
        future: _futureDispositivos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay dispositivos configurados.'));
          }

          final dispositivos = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.85,
            ),
            itemCount: dispositivos.length,
            itemBuilder: (context, index) {
              final dispositivo = dispositivos[index];
              final bool isOn = dispositivo.estado == 'on';

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: isOn ? Colors.indigo.shade50 : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  key: ValueKey(dispositivo.id),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            dispositivo.tipo == 'climatizacion' ? Icons.ac_unit :
                            dispositivo.tipo == 'iluminacion' ? Icons.lightbulb :
                            dispositivo.tipo == 'persiana' ? Icons.blinds : Icons.power,
                            color: isOn ? Colors.indigo : Colors.grey,
                            size: 32,
                          ),
                          Row(
                            children: [
                              Text(
                                dispositivo.marca.toUpperCase(),
                                style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => _eliminarDispositivo(dispositivo.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dispositivo.nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (dispositivo.tipo == 'climatizacion') ...[
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () => _mostrarControlesClima(dispositivo),
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Modo: ${dispositivo.modoClima?.toUpperCase()} ⚙️', style: const TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold)),
                                    Text('Actual: ${dispositivo.temperaturaActual}°C', style: const TextStyle(fontSize: 12)),
                                    Text('Objetivo: ${dispositivo.temperaturaDeseada}°C', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                            value: isOn,
                            onChanged: (value) => _alternarEstado(dispositivo),
                            activeColor: Colors.indigo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // 🔥 AQUI ESTÁ LA MAGIA: Una columna con los dos botones flotantes apilados
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "boton_sol_global", // Importante poner etiquetas distintas
            onPressed: _mostrarFormularioEntornoGlobal,
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            child: const Icon(Icons.wb_sunny),
          ),
          const SizedBox(height: 16), // Separación entre los dos botones
          FloatingActionButton(
            heroTag: "boton_añadir",
            onPressed: _mostrarFormularioCrear,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}