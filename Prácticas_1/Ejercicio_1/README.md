## Descripción del Ejercicio

El sistema simula dos tipos de partidas simultáneas con un número inicial `N` de jugadores (definido por el usuario en tiempo de ejecución):
* **Modalidad Competitiva:** Partidas de alta tensión donde el 20% de los jugadores abandona la partida (*rage quit*) antes de terminar.
* **Modalidad Casual:** Partidas relajadas donde solo el 10% de los jugadores se desconecta.

Ambas partidas tienen una duración estricta de 60 segundos y los abandonos se procesan de forma simultánea en la mitad de la ejecución.

## Tecnologías y Conceptos Aplicados

* **Lenguaje:** Java
* **Patrones de Diseño:** * **Factoría Abstracta (Abstract Factory):** Para agrupar las familias de productos (`Partida` y `Jugador`) asegurando que los jugadores competitivos solo entren en partidas competitivas, y viceversa.
    * **Método Factoría (Factory Method):** Para la instanciación concreta de los objetos.
* **Concurrencia:** Uso de hebras (`Threads` y la interfaz `Runnable`) para ejecutar ambas partidas de forma 100% simultánea.

## Estructura de Clases

El código está organizado en 6 archivos principales para mantener un diseño limpio y evitar la explosión de clases:

1.  `Main.java`: Cliente principal que solicita el número de jugadores y orquesta las hebras.
2.  `FactoriaPartidaYJugador.java`: Interfaz base de la factoría.
3.  `Jugador.java` / `Partida.java`: Productos abstractos base.
4.  `FactoriaCompetitiva.java` / `FactoriaCasual.java`: Archivos que agrupan las factorías concretas y sus respectivos productos específicos.
