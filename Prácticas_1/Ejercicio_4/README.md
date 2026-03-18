# Ejercicio 4: Autenticación con Filtros de Intercepción

Este repositorio contiene la solución al Ejercicio 4, implementado en Ruby. El objetivo es validar las credenciales de un usuario (correo y contraseña) aplicando el patrón de diseño Filtros de Intercepción (Intercepting Filter). Esto permite encadenar comprobaciones de seguridad modulares antes del procesamiento final, sin necesidad de modificar las clases existentes.

## Estructura del Proyecto

El código está organizado en dos archivos para separar la lógica del programa de la interacción con el usuario:

* `autenticacion.rb`: Contiene el módulo principal con la definición de la petición (Request), la interfaz base mediante Mixins, los filtros concretos, la cadena de ejecución (FilterChain), el gestor y el destino final (Target).
* `main.rb`: Es el punto de entrada del programa. Importa la lógica, instancia y encadena los filtros, y solicita las credenciales al usuario por terminal.

## Validaciones Implementadas

Cada comprobación se ejecuta en su propia clase independiente. El flujo se interrumpe si alguna de estas reglas no se cumple:

**Filtros de Correo:**
1.  Verifica que el correo contenga texto antes del carácter '@'.
2.  Verifica que el dominio sea exclusivamente 'gmail.com' o 'hotmail.com'.

**Filtros de Contraseña:**
3.  Comprueba que la longitud mínima sea de 8 caracteres.
4.  Exige la presencia de al menos una letra mayúscula.
5.  Exige la presencia de al menos un número.

## Ejecución

Para iniciar la validación, abre una terminal en la carpeta del proyecto y ejecuta el archivo principal con el intérprete de Ruby:

```bash
ruby main.rb
