# Práctica 3: Sistema de Gestión de Reservas Turísticas

## Descripción del Proyecto
Esta práctica consiste en el desarrollo de una plataforma de gestión de paquetes vacacionales mediante **Flutter/Dart**. El objetivo principal es la implementación de un sistema jerárquico que permita la creación de servicios (vuelos y hoteles) y su agrupación en paquetes, aplicando patrones de diseño orientados a objetos para gestionar dinámicamente las políticas de precios.

## Arquitectura y Patrones de Diseño
El diseño del sistema se ha basado en dos patrones fundamentales para garantizar la escalabilidad y el desacoplamiento:

1. **Patrón Composite**: Utilizado para la gestión jerárquica de `ServicioTuristico`. Tanto los elementos hoja (`Vuelo`, `Hotel`) como los compuestos (`Paquete`) implementan la misma interfaz, permitiendo tratar a todos los elementos del sistema de forma polimórfica mediante el método `getPrecio()`.
2. **Patrón Strategy**: Implementado para encapsular las reglas de tarifación. Los servicios delegan el cálculo de su coste a objetos `PoliticaVuelo` o `PoliticaHotel`, permitiendo asignar o cambiar las reglas de negocio en tiempo de ejecución sin modificar las clases de servicio.

> **Nota de Diseño**: Se ha respetado estrictamente el encapsulamiento de constantes internas dentro de las clases de estrategia (ej. recargos, multiplicadores), evitando la inyección de dependencias a través del constructor.

## Requisitos Técnicos
* **Framework**: Flutter (Dart).
* **Gestión de Estado**: Uso de `StatefulWidget` y `setState` para la actualización dinámica de la interfaz y el recálculo del precio total del paquete.
* **UI**: Interfaz interactiva que permite:
    * Configuración de servicios (Vuelo/Hotel).
    * Selección dinámica de políticas de precios mediante menús.
    * Visualización en tiempo real del desglose y coste total del paquete.

## Plan de Pruebas Unitarias
El proyecto incluye una suite de 12 pruebas unitarias desarrolladas con el paquete `test` de Dart, organizadas en los siguientes grupos:

### 1. Grupo: Políticas de Precio
* Validación del cálculo fijo en `TarifaLowCost`.
* Verificación del multiplicador en `TarifaBusiness`.
* Cálculo correcto de `RegimenSoloAlojamiento`.
* Validación del suplemento en `RegimenTodoIncluido`.

### 2. Grupo: Servicios Individuales (Hojas)
* Gestión de excepciones: Precio base negativo en `Vuelo`.
* Gestión de excepciones: Cero o menos noches en `Hotel`.
* Validación de delegación en `getPrecio()` para `Vuelo`.
* Validación de delegación en `getPrecio()` para `Hotel`.

### 3. Grupo: Agrupación de Paquetes
* `getPrecio()` inicial en paquetes vacíos (0).
* Suma aritmética correcta de componentes directos.
* Validación de recursividad en paquetes anidados.
* Actualización dinámica del precio tras modificar la política de un hijo.
