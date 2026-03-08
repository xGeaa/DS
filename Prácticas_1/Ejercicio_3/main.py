# ============================================================
# Nombre del archivo: main.py
# Asignatura: Desarrollo del Software
# Grupo de Prácticas: 3
# Autor: Alejandro Gea Martínez     
# Fecha de creación: 04/03/2026
# Descripción: Este archivo es el main del proyecto donde se gestiona la interacción con el usuario y se ejecutan las estrategias de scrap.
# Versión: 1.0
# Dependencias: estrategias.py
# ============================================================

from estrategias import ScrapBeautifulSoup, ScrapSelenium, ContextoScrap

def seleccionarScrap(opcion):
    opciones = {
        1: ScrapBeautifulSoup(),
        2: ScrapSelenium()
    }
    return opciones.get(opcion)

def main():
    print("Seleccione la estrategia de scrap:")
    print("1. BeautifulSoup")
    print("2. Selenium")
    
    opcion = int(input("Ingrese el número de la estrategia: "))
    estrategia = seleccionarScrap(opcion)
    
    if estrategia is None:
        print("Opción no válida.")
        return
    
    contexto = ContextoScrap(estrategia)
    
    url =  "https://www.scrapethissite.com/pages/forms/"
    contexto.realizar_scrap(url)
    
    
if __name__ == "__main__":
    main()