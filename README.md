# Prácticas de Desarrollo de Software (Curso 2025-2026) 🚀

Este repositorio contiene el desarrollo completo de las prácticas de la asignatura **Desarrollo de Software** del Grado en Ingeniería Informática en la Escuela Técnica Superior de Ingeniería Informática y de Telecomunicación (ETSIIT), Universidad de Granada (UGR).

El objetivo central de este repositorio es demostrar la asimilación de competencias en arquitectura de software, modelado de sistemas relacionales, pruebas de software automatizadas y, fundamentalmente, la correcta aplicación práctica de los patrones de diseño de la metodología GoF (Gang of Four).

---

## 🛠️ Tecnologías y Entornos Utilizados
A lo largo del curso se ha trabajado con un ecosistema tecnológico diverso, forzando la adaptabilidad e interoperabilidad entre lenguajes y plataformas:
* **Lenguajes de Programación:** Java, Python, Ruby, Dart.
* **Frameworks y Librerías:** Flutter (Mobile, Desktop & Web), Ruby on Rails (API Mode), BeautifulSoup, Selenium WebDriver.
* **Persistencia:** SQLite.
* **Herramientas de Ingeniería:** LaTeX (Overleaf) para las memorias técnicas y Git/GitHub para el control de versiones ramificado.

---

## 📂 Índice de Contenidos del Repositorio

El repositorio se estructura modularmente dividiéndose en las grandes entregas temporales exigidas por la guía docente:

### 📁 Práctica 1: Patrones Creacionales y Estructurales Básicos
Ejercicios independientes orientados a la implementación de patrones GoF puros y arquitecturas desacopladas:
* **Ejercicio 1 (Java):** Simulación de partidas multijugador asíncronas concurrentes (Hebras/Runnable) combinando los patrones **Abstract Factory** y **Factory Method**.
* **Ejercicio 2 (Python):** Extensión dinámica de funcionalidades (traducción y análisis de sentimientos) para un modelo de lenguaje (LLM) conectado a la API de *Hugging Face* mediante el patrón **Decorator**.
* **Ejercicio 3 (Python):** Extracción automatizada de datos (Web Scraping) con selección dinámica en tiempo de ejecución de motores de parseo (BeautifulSoup vs. Selenium WebDriver en modo *headless*) aplicando el patrón **Strategy**.
* **Ejercicio 4 (Ruby):** Flujo seguro de autenticación perimetral y validación por capas de seguridad modulares aplicando el patrón **Intercepting Filter** (Filtros de Intercepción).
* **Ejercicio 5 (Individual):** Sistema IoT de traducción de lecturas de hardware (*Celsius/Fahrenheit*) interoperable sin modificación de código mediante el patrón **Adapter**.

### 📁 Práctica 2: Arquitecturas Multiplataforma y Mantenimiento Adaptativo
Migración hacia tecnologías móviles y reactivas potenciando el mantenimiento perfectivo de código heredado:
* **Individuales (Flutter):** * Calculadora de proyecciones financieras financiera estructurada mediante **Factory Method**.
  * Gestor reactivo de costos de suscripciones mensuales.
* **Grupales (Flutter):**
  * Mantenimiento adaptativo y sistema de notificaciones sobre el interceptor de filtros de la P1.
  * Juego conversacional con inteligencia artificial conectada a la API de *Gemini* (`gemini-2.5-flash`), aplicando capas de defensa dinámicas (prompts estrictos, bloqueos de palabras y límites de longitud) mediante el patrón **Decorator**.

### 📁 Práctica 3: Gestión Jerárquica y Planificación de Pruebas Automatizadas
Diseño e implementación de un cotizador de paquetes vacacionales combinando patrones de datos y lógica dinámica, acompañado de una suite estricta de **12 test unitarios organizados en grupos**:
* **Lógica del Software:** Estructuración jerárquica y recursiva mediante el patrón **Composite** (Servicios Turísticos y Paquetes anidados) delegando el cálculo de tarifas en el patrón **Strategy** (LowCost/Business para vuelos; SoloAlojamiento/TodoIncluido para hoteles).
* **Suite de Pruebas (`test` en Dart):** Verificación aislada de políticas de precio, robustez de constructores (excepciones ante datos negativos) y propagación reactiva de cambios en el árbol estructural.

### 📁 Práctica 4: Proyecto de Síntesis - Ecosistema IoT Domótico End-to-End
Proyecto final de integración completa que engloba el desarrollo integrado de un backend y un frontend comunicados asíncronamente mediante una API RestFUL:
* **`mecahome_api` (Backend Rails):** Base de datos relacional SQLite encargada de procesar el estado real de la vivienda mediante callbacks de ciclo de vida e inyección de patrones complejos en caliente (**Adapter** para marcas de hardware heterogéneas y **Strategy** para la simulación algorítmica de los modos de climatización).
* **`mecahome` (Frontend Flutter):** Panel de control responsivo web/móvil con operaciones CRUD persistidas instantáneamente a través de solicitudes HTTP y sincronización reactiva local con `StatefulBuilder`.

---

## 📊 Criterios de Calidad del Software Aplicados
De acuerdo con las pautas de evaluación de la asignatura, todo el software depositado en este repositorio se rige por:
1. **Fidelidad Absoluta a los Patrones:** Cumplimiento explícito del propósito nativo de cada patrón según la literatura clásica de diseño.
2. **Ausencia de Código Redundante:** Alta reutilización de métodos y encapsulamiento de constantes en clases de pertenencia.
3. **Robustez ante Errores:** Validaciones estrictas y control de excepciones en tiempo de ejecución (*Null Pointer*, parámetros corruptos o estados asíncronos frágiles).
