import 'package:flutter/material.dart';
import 'models/secret_keeper.dart';
import 'models/basic_secret_keeper.dart';
import 'decorators/strong_system_prompt_decorator.dart';
import 'decorators/keyword_block_decorator.dart';
import 'decorators/length_limit_decorator.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PantallaPrincipal(),
  ));
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // Control de navegación: 0 = Menú, 1 = Chat
  int _indiceActual = 0;
  int nivelDificultad = 1;

  final TextEditingController _controller = TextEditingController();
  String _respuesta = "Soy el Guardián de la Contraseña. ¿Qué quieres?";
  bool _cargando = false;

  // Fábrica de Guardianes (Patrón Decorator)
  SecretKeeper _obtenerGuardianSegunNivel() {
    SecretKeeper guardian = BasicSecretKeeper();

    if (nivelDificultad == 1) return guardian;
    if (nivelDificultad == 2) return StrongSystemPromptDecorator(guardian);
    if (nivelDificultad == 3) return KeywordBlockDecorator(StrongSystemPromptDecorator(guardian));
    if (nivelDificultad == 4) {
      return LengthLimitDecorator(KeywordBlockDecorator(StrongSystemPromptDecorator(guardian)));
    }
    return guardian;
  }

  void _enviarMensaje() async {
    if (_controller.text.isEmpty) return;
    setState(() => _cargando = true);

    final guardianActual = _obtenerGuardianSegunNivel();
    final texto = await guardianActual.ask(_controller.text);

    setState(() {
      _respuesta = texto;
      _cargando = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos IndexedStack para alternar entre Menú y Chat
      body: IndexedStack(
        index: _indiceActual,
        children: [
          _buildMenu(),
          _buildChat(),
        ],
      ),
    );
  }

  // --- VISTA 1: MENÚ DE SELECCIÓN ---
  Widget _buildMenu() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [Colors.blue.shade900, Colors.black],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shield, size: 80, color: Colors.white),
          const SizedBox(height: 20),
          const Text(
            "ELIGE A TU GUARDIÁN",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          _botonNivel(1, "Nivel Básico", "IA Base sin protección", Colors.blue),
          _botonNivel(2, "Nivel Fácil", "IA con Personalidad Dura", Colors.green),
          _botonNivel(3, "Nivel Normal", "IA con Bloqueo de Palabras", Colors.orange),
          _botonNivel(4, "Nivel Difícil", "IA con Límite de Respuesta", Colors.red),
        ],
      ),
    );
  }

  Widget _botonNivel(int nivel, String titulo, String sub, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          setState(() {
            nivelDificultad = nivel;
            _respuesta = "Has entrado al Nivel $nivel. Intenta descubrir mi contraseña.";
            _indiceActual = 1; // Vamos al chat
          });
        },
        child: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.white24, child: Text("$nivel")),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- VISTA 2: EL CHAT ---
  Widget _buildChat() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel $nivelDificultad: ${_nombreNivel()}"),
        backgroundColor: _colorSegunNivel(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => _indiceActual = 0), // Volver al menú
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _cargando
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                  child: Text(
                    _respuesta,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const Divider(),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Pregunta al guardián...",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _enviarMensaje(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: _colorSegunNivel(), foregroundColor: Colors.white),
                onPressed: _cargando ? null : _enviarMensaje,
                icon: const Icon(Icons.send),
                label: const Text("Interrogar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _nombreNivel() {
    if (nivelDificultad == 1) return "Básico";
    if (nivelDificultad == 2) return "Fácil";
    if (nivelDificultad == 3) return "Normal";
    return "Difícil";
  }

  Color _colorSegunNivel() {
    if (nivelDificultad == 1) return Colors.blue.shade700;
    if (nivelDificultad == 2) return Colors.green.shade700;
    if (nivelDificultad == 3) return Colors.orange.shade700;
    return Colors.red.shade700;
  }
}
