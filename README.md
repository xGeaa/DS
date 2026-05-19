# Prácticas de Desarrollo de Software (Curso 2025-2026) 🚀

[cite_start]Este repositorio contiene el desarrollo completo de las prácticas de la asignatura **Desarrollo de Software** del 3º curso del Grado en Ingeniería Informática en la Escuela Técnica Superior de Ingeniería Informática y de Telecomunicación (ETSIIT), Universidad de Granada (UGR)[cite: 2, 3, 5, 6, 7].

[cite_start]El objetivo central de este repositorio es demostrar la asimilación de competencias en arquitectura de software, modelado de sistemas relacionales, pruebas de software automatizadas y, fundamentalmente, la correcta aplicación práctica de los patrones de diseño de la metodología GoF (Gang of Four)[cite: 33, 150, 191, 234, 236].

---

## 🛠️ Tecnologías y Entornos Utilizados
[cite_start]A lo largo del curso se ha trabajado con un ecosistema tecnológico diverso, forzando la adaptabilidad e interoperabilidad entre lenguajes y plataformas[cite: 38, 147]:
* [cite_start]**Lenguajes de Programación:** Java, Python, Ruby, Dart[cite: 51, 69, 134, 171].
* [cite_start]**Frameworks y Librerías:** Flutter (Mobile, Desktop & Web), Ruby on Rails (API Mode), BeautifulSoup, Selenium WebDriver[cite: 121, 122, 171, 232].
* [cite_start]**Persistencia:** SQLite[cite: 232, 237].
* [cite_start]**Herramientas de Ingeniería:** LaTeX (Overleaf) para las memorias técnicas y Git/GitHub para el control de versiones ramificado[cite: 22, 23, 227].

---

## 📂 Índice de Contenidos del Repositorio

[cite_start]El repositorio se estructura modularmente dividiéndose en las grandes entregas temporales exigidas por la guía docente:

### [cite_start]📁 Práctica 1: Patrones Creacionales y Estructurales Básicos [cite: 33]
Ejercicios independientes orientados a la implementación de patrones GoF puros y arquitecturas desacopladas:
* [cite_start]**Ejercicio 1 (Java):** Simulación de partidas multijugador asíncronas concurrentes (Hebras/Runnable) combinando los patrones **Abstract Factory** y **Factory Method**[cite: 40, 50, 52].
* [cite_start]**Ejercicio 2 (Python):** Extensión dinámica de funcionalidades (traducción y análisis de sentimientos) para un modelo de lenguaje (LLM) conectado a la API de *Hugging Face* mediante el patrón **Decorator**[cite: 69, 71].
* [cite_start]**Ejercicio 3 (Python):** Extracción automatizada de datos (Web Scraping) con selección dinámica en tiempo de ejecución de motores de parseo (BeautifulSoup vs. Selenium WebDriver en modo *headless*) aplicando el patrón **Strategy**[cite: 107, 108, 120, 121, 122].
* [cite_start]**Ejercicio 4 (Ruby):** Flujo seguro de autenticación perimetral y validación por capas de seguridad modulares aplicando el patrón **Intercepting Filter** (Filtros de Intercepción)[cite: 124, 126, 133, 134].
* [cite_start]**Ejercicio 5 (Individual):** Sistema IoT de traducción de lecturas de hardware (*Celsius/Fahrenheit*) interoperable sin modificación de código mediante el patrón **Adapter**[cite: 136, 137, 138, 141].

### [cite_start]📁 Práctica 2: Arquitecturas Multiplataforma y Mantenimiento Adaptativo [cite: 147]
[cite_start]Migración hacia tecnologías móviles y reactivas potenciando el mantenimiento perfectivo de código heredado[cite: 149, 171]:
* [cite_start]**Individuales (Flutter):** * Calculadora de proyecciones financieras estructurada mediante **Factory Method**[cite: 154, 156].
  * [cite_start]Gestor reactivo de costos de suscripciones mensuales[cite: 163, 164].
* **Grupales (Flutter):**
  * [cite_start]Mantenimiento adaptativo y sistema de notificaciones sobre el interceptor de filtros de la P1[cite: 171, 173].
  * [cite_start]Juego conversacional con inteligencia artificial conectada a la API de *Gemini* (`gemini-2.5-flash`), aplicando capas de defensa dinámicas (prompts estrictos, bloqueos de palabras y límites de longitud) mediante el patrón **Decorator**[cite: 174, 177, 183].

### [cite_start]📁 Práctica 3: Gestión Jerárquica y Planificación de Pruebas Automatizadas [cite: 189, 190]
[cite_start]Diseño e implementación de un cotizador de paquetes vacacionales combinando patrones de datos y lógica dinámica [cite: 194][cite_start], acompañado de una suite estricta de **12 test unitarios organizados en grupos**[cite: 215]:
* [cite_start]**Lógica del Software:** Estructuración jerárquica y recursiva mediante el patrón **Composite** (Servicios Turísticos y Paquetes anidados) delegando el cálculo de tarifas en el patrón **Strategy** (LowCost/Business para vuelos; SoloAlojamiento/TodoIncluido para hoteles)[cite: 197, 198, 201, 202, 203, 204, 213].
* [cite_start]**Suite de Pruebas (`test` en Dart):** Verificación aislada de políticas de precio, robustez de constructores (excepciones ante datos negativos) y propagación reactiva de cambios en el árbol estructural[cite: 210, 211, 214, 219].

### [cite_start]📁 Práctica 4: Proyecto de Síntesis - Ecosistema IoT Domótico End-to-End [cite: 228]
[cite_start]Proyecto final de integración completa que engloba el desarrollo integrado de un backend y un frontend comunicados asíncronamente mediante una API RestFUL[cite: 231, 232]:
* [cite_start]**`mecahome_api` (Backend Rails):** Base de datos relacional SQLite encargada de procesar el estado real de la vivienda mediante callbacks de ciclo de vida e inyección de patrones complejos en caliente (**Adapter** para marcas de hardware heterogéneas y **Strategy** para la simulación algorítmica de los modos de climatización)[cite: 232, 234].
* **`mecahome` (Frontend Flutter):** Panel de control responsivo web/móvil con operaciones CRUD persistidas instantáneamente a través de solicitudes HTTP y sincronización reactiva local con `StatefulBuilder`[cite: 232, 235, 236].

---

## 📊 Criterios de Calidad del Software Aplicados
De acuerdo con las pautas de evaluación de la asignatura, todo el software depositado en este repositorio se rige por[cite: 13, 14]:
1. **Fidelidad Absoluta a los Patrones:** Cumplimiento explícito del propósito nativo de cada patrón según la literatura clásica de diseño[cite: 18, 150].
2. **Ausencia de Código Redundante:** Alta reutilización de métodos y encapsulamiento de constantes en clases de pertenencia[cite: 19, 205].
3. **Robustez ante Errores:** Validaciones estrictas y control de excepciones en tiempo de ejecución (*Null Pointer*, parámetros corruptos o estados asíncronos frágiles)[cite: 17].
