import 'dart:ui';
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

  void _alternarEstado(Dispositivo dispositivo) async {
    String nuevoEstado = dispositivo.estado == 'on' ? 'off' : 'on';
    bool exito = await _apiService.actualizarDispositivo(dispositivo.id, {'estado': nuevoEstado});
    if (exito) {
      _cargarDispositivos();
    }
  }

  void _eliminarDispositivo(Dispositivo dispositivo) async {
    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1E293B),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Desvincular Hardware',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)
              ),
            ),
          ],
        ),
        content: Text(
          'Esta acción eliminará "${dispositivo.nombre}" permanentemente de tu red.',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 13)
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent.withOpacity(0.15),
              foregroundColor: Colors.redAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            ),
            child: const Text('Eliminar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      bool exito = await _apiService.borrarDispositivo(dispositivo.id);
      if (exito) {
        _cargarDispositivos();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Dispositivo eliminado con éxito', style: TextStyle(color: Colors.white)),
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF0F172A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    }
  }

  void _mostrarFormularioCrear() {
    final nombreController = TextEditingController();
    String tipoSeleccionado = 'iluminacion';
    String marcaSeleccionada = 'philips';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF161E2D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
          top: 20, left: 24, right: 24,
        ),
        child: StatefulBuilder(
          builder: (context, setModalState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(width: 36, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 24),
              const Text('Integrar Hardware', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.5, color: Colors.white)),
              const Text('Parámetros de configuración del nuevo nodo.', style: TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 24),

              TextField(
                controller: nombreController,
                style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'Identificador del dispositivo',
                  labelStyle: const TextStyle(color: Colors.white54),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white12)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.cyan)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: tipoSeleccionado,
                dropdownColor: const Color(0xFF1E293B),
                style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  labelStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white12)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.cyan)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                ),
                items: const [
                  DropdownMenuItem(value: 'iluminacion', child: Text('Iluminación')),
                  DropdownMenuItem(value: 'climatizacion', child: Text('Climatización')),
                  DropdownMenuItem(value: 'energia', child: Text('Gestión de Energía')),
                ],
                onChanged: (val) => setModalState(() => tipoSeleccionado = val!),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: marcaSeleccionada,
                dropdownColor: const Color(0xFF1E293B),
                style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  labelText: 'Protocolo / Fabricante',
                  labelStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white12)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.cyan)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                ),
                items: const [
                  DropdownMenuItem(value: 'philips', child: Text('Philips Hue')),
                  DropdownMenuItem(value: 'xiaomi', child: Text('Xiaomi IoT')),
                  DropdownMenuItem(value: 'nest', child: Text('Google Nest')),
                ],
                onChanged: (val) => setModalState(() => marcaSeleccionada = val!),
              ),
              const SizedBox(height: 32),

              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  if (nombreController.text.isNotEmpty) {
                    Map<String, dynamic> nuevoDispositivo = {
                      'nombre': nombreController.text,
                      'tipo': tipoSeleccionado,
                      'marca': marcaSeleccionada,
                      'estado': 'off',
                    };

                    if (tipoSeleccionado == 'climatizacion') {
                      nuevoDispositivo['temperatura_actual'] = 24.0;
                      nuevoDispositivo['temperatura_deseada'] = 21.0;
                      nuevoDispositivo['modo_clima'] = 'eco';
                    }

                    bool exito = await _apiService.crearDispositivo(nuevoDispositivo);
                    if (exito) {
                      Navigator.pop(context);
                      _cargarDispositivos();
                    }
                  }
                },
                child: const Text('Vincular Hardware', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Dispositivo?> _cambiarTemperaturaDeseada(Dispositivo disp, double cambio) async {
    double nuevaTemp = (disp.temperaturaDeseada ?? 22.0) + cambio;
    bool exito = await _apiService.actualizarDispositivo(disp.id, {
      'temperatura_deseada': nuevaTemp
    });

    if (exito) {
      _cargarDispositivos();
      disp.temperaturaDeseada = nuevaTemp;
      return disp;
    }
    return null;
  }

  void _cambiarModoClima(Dispositivo disp, String nuevoModo) async {
    bool exito = await _apiService.actualizarDispositivo(disp.id, {
      'modo_clima': nuevoModo
    });
    if (exito) _cargarDispositivos();
  }

  void _mostrarControlesClima(Dispositivo dispositivo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF161E2D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(28.0),
        child: StatefulBuilder(
          builder: (context, setModalState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              Text(dispositivo.nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.5, color: Colors.white)),
              const Text('Control de Climatización', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w400, fontSize: 12)),
              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white12, width: 1)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filledTonal(
                      style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.05), foregroundColor: Colors.white),
                      icon: const Icon(Icons.remove_rounded, size: 20),
                      onPressed: () async {
                        Dispositivo? actualizado = await _cambiarTemperaturaDeseada(dispositivo, -0.5);
                        if (actualizado != null) setModalState(() => dispositivo = actualizado);
                      },
                    ),
                    Container(
                      constraints: const BoxConstraints(minWidth: 110),
                      child: Center(
                        child: Text(
                            '${dispositivo.temperaturaDeseada}°',
                            style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w300, letterSpacing: -2, color: Colors.white)
                        ),
                      ),
                    ),
                    IconButton.filledTonal(
                      style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.05), foregroundColor: Colors.white),
                      icon: const Icon(Icons.add_rounded, size: 20),
                      onPressed: () async {
                        Dispositivo? actualizado = await _cambiarTemperaturaDeseada(dispositivo, 0.5);
                        if (actualizado != null) setModalState(() => dispositivo = actualizado);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ESTRATEGIA OPERATIVA', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, letterSpacing: 1.5, color: Colors.white54))
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: Colors.white,
                      selectedForegroundColor: Colors.black,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white54,
                      side: const BorderSide(color: Colors.white12)
                  ),
                  segments: const [
                    ButtonSegment(value: 'eco', label: Text('ECO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                    ButtonSegment(value: 'confort', label: Text('CONFORT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                    ButtonSegment(value: 'vacaciones', label: Text('VACACIONES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
                  ],
                  selected: {dispositivo.modoClima ?? 'eco'},
                  onSelectionChanged: (Set<String> nuevoModo) {
                    _cambiarModoClima(dispositivo, nuevoModo.first);
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ETIQUETA MICRO-TIPOGRÁFICA QUE COMBINA TIPO Y MARCA
  Widget _buildMicroEtiqueta(String tipo, String marca, Color color, bool isOn) {
    String tipoAbreviado = 'ENCHUFE';
    if (tipo == 'climatizacion') tipoAbreviado = 'CLIMA';
    else if (tipo == 'iluminacion') tipoAbreviado = 'LUZ';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: isOn ? color.withOpacity(0.12) : Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isOn ? color.withOpacity(0.3) : Colors.white12, width: 0.5),
      ),
      child: Text(
        '$tipoAbreviado · ${marca.toUpperCase()}', // Identificación completa y compacta
        style: TextStyle(
          fontSize: 7.5,
          color: isOn ? color : Colors.white54,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F172A),
              Color(0xFF0B0F19),
              Color(0xFF020617),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // CABECERA SUPERIOR (Header)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MecaHome', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, letterSpacing: -0.5, color: Colors.white)),
                        SizedBox(height: 2),
                        Text('Control centralizado', style: TextStyle(fontSize: 12, color: Colors.white54, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.refresh_rounded, color: Colors.white54, size: 22),
                          onPressed: _cargarDispositivos,
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.05)),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
                            onPressed: _mostrarFormularioCrear,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // PANEL DE DISPOSITIVOS
              Expanded(
                child: FutureBuilder<List<Dispositivo>>(
                  future: _futureDispositivos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white54));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error de red: ${snapshot.error}', style: const TextStyle(color: Colors.redAccent, fontSize: 12)));
                    }

                    final listaDispositivos = snapshot.data ?? [];

                    if (listaDispositivos.isEmpty) {
                      return const Center(child: Text('Sin hardware vinculado.', style: TextStyle(color: Colors.white54, fontSize: 13)));
                    }

                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        // Relación de aspecto ultracompacta que exprime el espacio vertical al máximo
                        childAspectRatio: 2.7,
                      ),
                      itemCount: listaDispositivos.length,
                      itemBuilder: (context, index) {
                        final dispositivo = listaDispositivos[index];
                        final bool isOn = dispositivo.estado == 'on';

                        // Colores Neón minimalistas
                        Color brandColor = const Color(0xFF10B981); // Verde Energía
                        IconData iconData = Icons.power_rounded;
                        String statusText = isOn ? 'ON' : 'OFF';

                        if (dispositivo.tipo == 'climatizacion') {
                          brandColor = const Color(0xFF06B6D4); // Cyan Clima
                          iconData = Icons.ac_unit_rounded;
                          statusText = isOn ? '${dispositivo.temperaturaDeseada}°' : 'OFF';
                        } else if (dispositivo.tipo == 'iluminacion') {
                          brandColor = const Color(0xFFF59E0B); // Ámbar Luz
                          iconData = Icons.lightbulb_outline_rounded;
                        }

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(isOn ? 0.08 : 0.02),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isOn ? brandColor.withOpacity(0.4) : Colors.white.withOpacity(0.05),
                                  width: 1.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: dispositivo.tipo == 'climatizacion' ? () => _mostrarControlesClima(dispositivo) : () => _alternarEstado(dispositivo),
                                onLongPress: () => _eliminarDispositivo(dispositivo),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  child: Row(
                                    children: [
                                      // Icono iluminado a la izquierda
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: isOn ? brandColor.withOpacity(0.15) : Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(iconData, color: isOn ? brandColor : Colors.white38, size: 18),
                                      ),
                                      const SizedBox(width: 10),

                                      // Textos y Etiquetas Inline
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dispositivo.nombre,
                                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.white, letterSpacing: -0.2),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                // La nueva etiqueta súper compacta
                                                _buildMicroEtiqueta(dispositivo.tipo, dispositivo.marca, brandColor, isOn),
                                                const SizedBox(width: 6),
                                                // El estado pegado a la etiqueta ahorrando espacio
                                                Expanded(
                                                  child: Text(
                                                    statusText,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: isOn ? brandColor : Colors.white38,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Switch a la derecha
                                      Transform.scale(
                                        scale: 0.65,
                                        child: Switch.adaptive(
                                          value: isOn,
                                          onChanged: (value) => _alternarEstado(dispositivo),
                                          activeColor: brandColor,
                                          activeTrackColor: brandColor.withOpacity(0.3),
                                          inactiveThumbColor: Colors.white54,
                                          inactiveTrackColor: Colors.white12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}