# 🛡️ Guardián de IA: Desafío de Seguridad con Patrón Decorator

Proyecto de desarrollo móvil en **Flutter** que implementa un juego conversacional basado en IA. El objetivo es intentar extraer una palabra secreta de un Guardián, mientras este se protege mediante capas de seguridad aplicadas dinámicamente.

## 🎯 Objetivo
Implementar el **Patrón de Diseño Decorator** para envolver dinámicamente un objeto de comunicación con la IA (`BasicSecretKeeper`) con diversas capas de seguridad, evitando la explosión de subclases y permitiendo la combinación flexible de comportamientos en tiempo de ejecución.



## 🏗️ Arquitectura del Sistema

El sistema se basa en una interfaz común `SecretKeeper` que garantiza que tanto el componente base como sus decoradores cumplan el mismo contrato:

* **Componente Base (`BasicSecretKeeper`):** Implementación de la comunicación con la API de `Gemini 2.5-flash`. Comportamiento amigable y vulnerable.
* **Decorador Base (`SecretKeeperDecorator`):** Clase abstracta que implementa `SecretKeeper` y permite la inyección de dependencias para "envolver" a otro `SecretKeeper`.

### 🛡️ Capas de Defensa (Decoradores Concretos)
Cada decorador añade una lógica de seguridad adicional:

| Decorador | Función |
| :--- | :--- |
| **`StrongSystemPromptDecorator`** | Inyecta un System Prompt estricto, transformando la personalidad de la IA en un guardián gruñón. |
| **`KeywordBlockDecorator`** | Filtra los mensajes de entrada bloqueando intentos de *jailbreak* y palabras prohibidas (ej: "ignora", "revela", "jailbreak"). |
| **`LengthLimitDecorator`** | Intercepta la respuesta de la IA y la trunca si supera los 200 caracteres, forzando un comportamiento cortante. |

## 🚀 Funcionalidades Clave

* **Selección Dinámica:** Pantalla de configuración para combinar decoradores y crear niveles de dificultad personalizados (desde "Novato" hasta "Hardcore").
* **Interfaz de Chat:** Comunicación fluida y en tiempo real con la IA a través del modelo `gemini-2.5-flash`.
* **Seguridad Dinámica:** La lógica de filtrado se aplica en tiempo de ejecución basándose en la configuración del objeto decorado.

## 🛠️ Tecnologías Utilizadas

* **Flutter / Dart:** Framework de desarrollo UI.
* **Google Generative AI SDK:** Integración con Gemini API.
* **Patrón Decorator:** Para la composición flexible de filtros de seguridad.
