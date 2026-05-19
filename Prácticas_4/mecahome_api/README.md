# MecaHome API 🧠🏠

Este directorio contiene el **Backend (Servidor RESTful)** del sistema domótico inteligente *MecaHome*. El sistema está desarrollado utilizando **Ruby on Rails** configurado exclusivamente en modo API (`--api`) y utiliza **SQLite** como motor de persistencia relacional. 

Su responsabilidad exclusiva es centralizar las reglas de negocio complejas, gestionar el ciclo de vida de los dispositivos IoT y modelar comportamientos avanzados mediante patrones de diseño orientados a objetos de la metodología GoF (Gang of Four).

---

## 🛠️ Decisiones Arquitectónicas y Patrones GoF

Para evitar el acoplamiento del código y cumplir con los principios **SOLID**, el backend delega las responsabilidades lógicas en componentes independientes del modelo:

### 1. Patrón Structural: Adapter 🔌
* **Ubicación:** `app/models/adapters/`
* **Problema resuelto:** Cada fabricante de hardware (Philips, Xiaomi, Nest) cuenta con librerías y protocolos de comunicación heterogéneos. Invocarlos directamente en los controladores crearía un código rígido y frágil.
* **Solución:** El modelo `Dispositivo` expone una interfaz unificada. Mediante el método `.obtener_adaptador`, el sistema detecta la marca en la base de datos e instancia dinámicamente el adaptador correspondiente (`PhilipsHueAdapter`, `XiaomiPlugAdapter`), aislando por completo la sintaxis del fabricante de nuestra lógica interna. Cumple el **Principio de Abierto/Cerrado**.

### 2. Patrón Behavioral: Strategy 🎯
* **Ubicación:** `app/models/strategies/`
* **Problema resuelto:** Las reglas matemáticas para simular la climatización de la vivienda cambian drásticamente según las prioridades del usuario (Ahorro energético, Confort familiar o Apagado por Vacaciones). Programarlo con condicionales `if/else` anidados crearía un "Objeto Dios" (*God Object*).
* **Solución:** Se encapsuló cada algoritmo en una clase independiente (`ModoEco`, `ModoConfort`, `ModoVacaciones`). Al procesar un guardado, un callback del ciclo de vida (`before_save`) inyecta la estrategia elegida en tiempo de ejecución. El motor térmico calcula el salto térmico de forma ciega y dinámica según el "chip" algorítmico activo.

---

## 📂 Estructura de Archivos Clave

* 🛣️ `config/routes.rb`: Define los recursos RESTful expuestos para el cliente (mapeo estricto de verbos HTTP hacia las acciones del controlador).
* 🛡️ `config/initializers/cors.rb`: Configuración perimetral de seguridad. Permite el intercambio de recursos entre orígenes cruzados (**CORS**), autorizando explícitamente las peticiones entrantes desde los puertos locales de desarrollo de Flutter Web.
* 🎛️ `app/controllers/dispositivos_controller.rb`: Controlador "delgado" (*Skinny Controller*). Su única función es interceptar las peticiones HTTP de Flutter, aplicar los *Strong Parameters* de seguridad y coordinar las respuestas en formato JSON serializado.
* 💎 `app/models/dispositivo.rb`: Modelo "gordo" (*Fat Model*). Aloja el estado físico de los dispositivos de la base de datos y orquesta las invocaciones a los submódulos de estrategias y adaptadores.
* 💾 `db/migrate/`: Aloja las migraciones estructuradas encargadas de modelar el esquema físico relacional de la tabla de dispositivos en SQLite.

---

## 🚀 Endpoints de la API REST

El servidor expone un CRUD síncrono completo sobre el recurso `dispositivos` bajo la dirección base `http://localhost:3000`:

| Verbo HTTP | Endpoint | Descripción | Payload esperado (JSON) |
| :--- | :--- | :--- | :--- |
| **GET** | `/dispositivos` | Obtiene la lista completa de dispositivos de la casa. | Ninguno |
| **POST** | `/dispositivos` | Da de alta un nuevo dispositivo IoT en el sistema. | `{ "nombre": "...", "tipo": "...", "marca": "..." }` |
| **PUT** | `/dispositivos/:id` | Actualiza cualquier atributo (estado, modo de clima, temperaturas). | `{ "estado": "on", "temperatura_deseada": 23.5 }` |
| **DELETE** | `/dispositivos/:id` | Elimina físicamente el registro de la base de datos. | Ninguno |

---

## 💻 Instalación y Despliegue Local

### 1. Instalar las dependencias del Servidor
Ejecuta Bundler desde la raíz de este directorio para descargar e instalar todas las gemas especificadas en el `Gemfile` (incluyendo `rack-cors`):
```bash
bundle install
