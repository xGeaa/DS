# MecaHome Dashboard 📱🏠

Este directorio contiene el **Frontend (Cliente Multiplataforma)** del sistema domótico inteligente *MecaHome*. La aplicación está desarrollada utilizando **Flutter** y **Dart**, implementando una interfaz de usuario reactiva, responsiva y totalmente desacoplada de la lógica de negocio compleja del servidor.

## 🚀 Características del Cliente
* **Salpicadero Responsivo:** Grid dinámico optimizado ergonómicamente para entornos móviles y vistas web emuladas.
* **Consumo de API RESTful:** Integración asíncrona nativa con el backend de Ruby on Rails mediante el protocolo HTTP.
* **Sincronización de Estado Local:** Gestión reactiva del árbol de widgets utilizando `StatefulBuilder` para resolver la persistencia visual en menús contextuales flotantes (`ModalBottomSheet`).
* **Operaciones CRUD en Tiempo Real:** Interfaz adaptada para la creación, lectura, actualización y destrucción de dispositivos IoT desde el panel.

---

## 📂 Estructura de Archivos Clave

El código fuente se organiza de manera modular dentro del directorio `lib/` para garantizar una alta cohesión y bajo acoplamiento:

* 📥 `lib/main.dart`: Punto de entrada de la aplicación. Configura los hilos de ejecución, el enrutamiento base y el tema visual global (colores, tipografías y estilos oscuros/claros).
* 📦 `lib/models/dispositivo.dart`: Modelo de datos fuertemente tipado. Centraliza la lógica de mapeo y las factorías de deserialización JSON (`Dispositivo.fromJson`) para transformar las respuestas del servidor en objetos Dart inmutables.
* 🌐 `lib/services/api_service.dart`: Capa de infraestructura de red. Encapsula las llamadas HTTP a los *endpoints* del backend (`GET`, `POST`, `PUT`, `DELETE`), abstrayendo a las vistas de la configuración de red y las cabeceras.
* 📺 `lib/screens/home_screen.dart`: Panel de control principal (UI). Renderiza el salpicadero mediante un `FutureBuilder` y gestiona las interacciones físicas del usuario (switches de estado, formularios de creación y controles del termostato).

---

## 🏗️ Integración Arquitectónica: El Rol de Flutter

Siguiendo las directrices de los patrones arquitectónicos cliente-servidor, este frontend actúa exclusivamente como un **mando a distancia agnóstico**:

1. **Aislamiento de Reglas de Negocio:** La interfaz no calcula los saltos térmicos ni conoce las marcas de los fabricantes. Cuando el usuario interactúa con un dispositivo, Flutter emite un payload JSON descriptivo hacia Rails (ej. `{ "modo_clima": "vacaciones" }`).
2. **Reactividad:** El backend procesa los patrones de diseño (**Strategy** y **Adapter**) y devuelve el nuevo estado consolidado. Flutter recibe la respuesta HTTP y redibuja las tarjetas instantáneamente mediante la gestión de estado local (`setState`).

---

## 🛠️ Pre-requisitos y Configuración

Antes de levantar el entorno de desarrollo, asegúrate de tener instalado el SDK de Flutter en tu máquina.

### 1. Instalar Dependencias
Desde la raíz de este directorio (`mecahome`), ejecuta el gestor de paquetes de Dart para descargar las librerías necesarias (como el cliente HTTP):
```bash
flutter pub get
