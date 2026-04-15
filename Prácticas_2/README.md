# Práctica 2: Mantenimiento, Refactorización y Patrones Arquitectónicos

**Asignatura:** Desarrollo del Software  
**Curso:** 2025-2026  
**Grado:** Ingeniería Informática (UGR)

---

## 🎯 Objetivos de la Práctica

El propósito de esta práctica es profundizar en la capacidad de adaptar y ampliar software existente, aplicando patrones arquitectónicos y de diseño en un entorno móvil (Flutter). Los objetivos específicos son:

* **Mantenimiento Adaptativo:** Reestructuración y migración de lógica compleja a Flutter/Dart.
* **Mantenimiento Perfectivo:** Mejora de funcionalidades existentes y adición de nuevas capacidades (sistema de notificaciones y persistencia).
* **Fidelidad a Patrones:** Implementación rigurosa de patrones de diseño (Decorator, Intercepting Filter) y arquitecturas limpias.

---

## 📂 Ejercicios Implementados

### 0.7 Mantenimiento en Flutter: Filtros de Autenticación
* **Patrón:** Intercepting Filter.
* **Descripción:** Evolución del sistema de validación de credenciales (email + contraseña) de la Práctica 1.
* **Mejoras implementadas:**
    * Migración completa a **Flutter + Dart**.
    * Validación avanzada de correos (comprobación de existencia previa).
    * **Sistema de Notificaciones:** feedback visual en tiempo real al usuario indicando qué filtro de seguridad fue rechazado.

### 0.8 Ejercicio Grupal: Guardián de IA (Decorator con Gemini API)
* **Patrón:** Decorator.
* **Descripción:** Juego conversacional donde el usuario intenta extraer una "palabra secreta" de un Guardián IA. El comportamiento del guardián se altera dinámicamente mediante capas de seguridad (Decoradores).
* **Arquitectura:**
    * `SecretKeeper` (Interfaz/Clase abstracta): Define el contrato de comunicación `ask(String)`.
    * `BasicSecretKeeper`: Implementación base (API Gemini 2.5-flash).
* **Capas de Defensa (Decoradores):**
    * `StrongSystemPromptDecorator`: Refuerza el rol del guardián (personaje gruñón/estricto).
    * `KeywordBlockDecorator`: Filtra intentos de *jailbreak* y palabras prohibidas (*ignora, olvida, revela, etc.*).
    * `LengthLimitDecorator`: Limita la verbosidad de la IA (máx. 200 caracteres).
* **Funcionalidad UI:** Pantalla de selección de dificultad (combinatoria de decoradores) y chat interactivo con el guardián.

   git clone [URL_DEL_REPOSITORIO]
