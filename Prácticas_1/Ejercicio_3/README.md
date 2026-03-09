# Ejercicio 3: Web Scraping con Patrón Strategy (Python)

## 📖 Descripción
Este programa implementa la extracción de datos estadísticos de equipos de hockey desde el sitio web oficial de pruebas [Scrape This Site](https://www.scrapethissite.com/pages/forms/). El sistema procesa las primeras **5 páginas** de resultados y permite al usuario elegir dinámicamente el motor de extracción en tiempo de ejecución.


## 📐 Patrón de Diseño: Strategy
Se ha aplicado el **Patrón Strategy** para separar la lógica de obtención de datos de la lógica de procesamiento. Este diseño permite intercambiar el motor de scraping de forma transparente según se necesite velocidad o la capacidad de procesar contenido dinámico.


### Estrategias Implementadas:
* **BeautifulSoup Strategy:** Utiliza las librerías `requests` y `BeautifulSoup` para obtener y parsear el HTML estático de la web.
* **Selenium Strategy:** Emplea `Selenium WebDriver` para acceder al navegador, procesar el HTML y extraer los elementos directamente del DOM.


## 📊 Datos Recolectados
Para cada equipo, se recolectan y procesan los siguientes campos estadísticos requeridos:
* **Nombre del equipo** (Team Name).
* **Año** (Year).
* **Victorias** (Wins) y **Derrotas** (Losses).
* **Derrotas en tiempo extra** (OT Losses).
* **Porcentaje de victorias** (Win %).
* **Goles a favor** (Goals For) y **Goles en contra** (Goals Against).
* **Diferencia de goles** (+/-).


Toda la información extraída se almacena automáticamente en un archivo con formato **CSV**.
