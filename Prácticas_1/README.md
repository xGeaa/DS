# Práctica 1: Patrones de Diseño Creacionales y Estructurales
**Asignatura:** Desarrollo del Software  
**Curso:** 2025-2026  
**Grado:** Ingeniería Informática (UGR)

---

## 🎯 Objetivos de la Práctica
De acuerdo al guión oficial, los objetivos principales son:
1. **Familiarización con herramientas** de diseño e implementación Orientada a Objetos (OO).
2. **Aplicación de patrones** creacionales y estructurales a problemas diversos.
3. **Destreza en el diseño OO** y adaptación a distintos lenguajes (Java, Python, Ruby).

---

## 📂 Ejercicios Implementados

### ☕ Ejercicio 1: Simulación Multijugador (Java)
* **Patrón:** Abstract Factory + Factory Method.
* **Descripción:** Simulación de partidas competitivas y casuales iniciadas simultáneamente mediante hebras (`Runnable`).
* **Características:** Gestión de desconexiones (10% - 20%) y duración de 60 segundos por partida.

### 🤖 Ejercicio 2: Decorador de LLM (Python)
* **Patrón:** Decorator.
* **Descripción:** Extensión dinámica de un modelo de lenguaje (Hugging Face API) para añadir traducción al español y análisis de sentimientos.
* **Configuración:** Parámetros gestionados a través de un archivo `config.json`.

### 🏒 Ejercicio 3: Web Scraping de Hockey (Python)
* **Patrón:** Strategy.
* **Descripción:** Extracción de estadísticas de 5 páginas del sitio *Scrape This Site*.
* **Estrategias:** 
    * **BeautifulSoup:** Para HTML estático.
    * **Selenium:** Para procesamiento del DOM en modo headless.

### 💎 Ejercicio 4: Filtros de Autenticación (Ruby)
* **Patrón:** Intercepting Filter.
* **Descripción:** Cadena de filtros para validar credenciales de usuario (formato de correo y reglas de seguridad de contraseña).
* **Tecnologías:** Implementado obligatoriamente en Ruby.

### 🌡️ Ejercicio 5: Adaptador Domótico (Individual)
* **Patrón sugerido:** Adapter.
* **Descripción:** Integración de sensores estadounidenses (Fahrenheit) en un panel de control europeo (Celsius) sin modificar las clases originales.

---


