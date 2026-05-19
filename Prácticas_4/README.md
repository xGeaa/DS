# Práctica 4: Sistema IoT Domótico Conectado (MecaHome) 🏡🚀

Este repositorio contiene la entrega completa de la **Práctica 4**, correspondiente al diseño, arquitectura e implementación de una plataforma domótica inteligente distribuida. El proyecto está dividido en dos grandes bloques desacoplados que interactúan de forma síncrona mediante una API REST:

1. **`mecahome_api` (Backend):** Servidor desarrollado en **Ruby on Rails** en modo API con persistencia relacional en **SQLite**. Es el cerebro del sistema y el encargado de encapsular las reglas de negocio y los patrones de diseño orientados a objetos.
2. **`mecahome` (Frontend):** Aplicación de cliente desarrollada en **Flutter** y **Dart**. Actúa como una interfaz reactiva, responsiva y agnóstica encargada de la visualización y el control de los dispositivos en tiempo real.

---

## 🏗️ Arquitectura General del Sistema

El ecosistema sigue un modelo de arquitectura **Cliente-Servidor de Acoplamiento Débil**. La comunicación entre ambos entornos se realiza puramente a través del protocolo HTTP, utilizando el intercambio de payloads en formato estandarizado **JSON**.

### Patrones de Diseño Implementados (Metodología GoF)
El verdadero núcleo técnico del proyecto reside en el backend de Rails, diseñado bajo principios **SOLID** para garantizar la extensibilidad y robustez ante el hardware real:

* **Patrón Adapter (Estructural):** Resuelve la heterogeneidad y fragmentación de los fabricantes de hardware del mercado (como *Philips Hue* o *Xiaomi*). El sistema expone una interfaz común de control y delega la traducción técnica de las peticiones en adaptadores específicos integrados en caliente.
* **Patrón Strategy (Comportamiento):** Aísla los algoritmos matemáticos de simulación térmica de la vivienda según las necesidades del usuario (`ModoEco`, `ModoConfort` y `ModoVacaciones`). El motor cambia de algoritmo de forma dinámica y transparente en función del estado de la base de datos sin alterar el bucle principal de control.

---

## 📂 Organización del Repositorio

```text
Prácticas_4/
├── README.md                  # Este archivo (Guía general del ecosistema)
│
├── mecahome_api/              # BACKEND (Ruby on Rails API)
│   ├── app/
│   │   ├── controllers/       # Controladores REST (Manejo de peticiones HTTP)
│   │   └── models/
│   │       ├── dispositivo.rb # Modelo principal (Orquestador de lógica)
│   │       ├── adapters/      # Clases del Patrón Adapter (Philips, Xiaomi, etc.)
│   │       └── strategies/    # Clases del Patrón Strategy (Eco, Confort, Vacaciones)
│   ├── config/                # Rutas y configuración perimetral de seguridad (CORS)
│   └── db/                    # Migraciones y base de datos relacional SQLite
│
└── mecahome/                  # FRONTEND (Flutter / Dart)
    ├── lib/
    │   ├── main.dart          # Punto de entrada y configuración del tema global
    │   ├── models/            # Modelos de datos y factorías de deserialización JSON
    │   ├── services/          # Cliente HTTP para el consumo asíncrono de la API
    │   └── screens/           # Interfaz de usuario (Salpicadero, Modales y Formularios)
