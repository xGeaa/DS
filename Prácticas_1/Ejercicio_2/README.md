# Ejercicio 2: HuggingFace y Patrón Decorator (Python)

## 📖 Descripción
Este programa implementa el uso de la API de Hugging Face para interactuar con modelos de lenguaje (LLM) y procesar texto de entrada. El sistema permite generar un resumen de un texto y aplicar funcionalidades adicionales como traducción y análisis de sentimiento.

El diseño permite combinar dinámicamente estas funcionalidades mediante el uso de decoradores, obteniendo diferentes resultados a partir de un mismo texto de entrada.


## 📐 Patrón de Diseño: Decorator
Se ha aplicado el **Patrón Decorator** para extender el comportamiento del modelo base sin modificar su implementación. Este patrón permite añadir nuevas funcionalidades envolviendo el objeto original de forma dinámica.

El modelo base (`BasicLLM`) se encarga de generar el resumen inicial, mientras que los decoradores añaden nuevas capas de procesamiento sobre dicho resultado.


### Decoradores Implementados:
* **BasicLLM:** Realiza la llamada a la API de Hugging Face para generar un resumen del texto.
* **TranslationDecorator:** Traduce el resumen generado a otro idioma utilizando un modelo de traducción.
* **SentimentDecorator:** Analiza el sentimiento del resumen generado y devuelve la etiqueta correspondiente (positivo, negativo, etc.).



## ⚙️ Funcionamiento del Sistema
El programa carga la configuración desde un archivo `JSON`, donde se especifican:
* El texto de entrada.
* El modelo para el resumen.
* El modelo de traducción.
* El modelo de análisis de sentimiento.
* El token de acceso a la API de Hugging Face.

A partir de estos datos, se crean diferentes combinaciones:
* **Resumen básico** (modelo base).
* **Resumen traducido** (decorador de traducción).
* **Análisis de sentimiento** (decorador de sentimiento).
* **Combinación de decoradores** (traducción + sentimiento).

Cada resultado se obtiene mediante llamadas a la API y se muestra por pantalla.


## 📊 Resultados Obtenidos
El sistema genera los siguientes resultados:
* **Resumen básico** del texto.
* **Resumen traducido** a otro idioma.
* **Etiqueta de sentimiento** del resumen.
* **Resultado combinado**, aplicando múltiples decoradores.