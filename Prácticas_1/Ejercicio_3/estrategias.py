# ============================================================
# Nombre del archivo: 
# Autor: 
# Fecha de creación: 
# Descripción: 
# Versión: 
# Dependencias: 
# Notas adicionales: 
# ============================================================

from abc import ABC, abstractmethod
import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import time
import csv


class EstrategiaScrap(ABC):
    @abstractmethod
    def scrap(self, url):
        pass
    
class ScrapBeautifulSoup(EstrategiaScrap):
    def scrap(self, url):
        # Implementación del scrap utilizando BeautifulSoup
        
        equipos_info = []
        url_paginada = f"{url}"
        
        for i in range(1, 6):
            print(f"Scrapeando página {i}...")
            
            r = requests.get(url_paginada)
            soup = BeautifulSoup(r.text, 'html.parser')

            equipos = soup.find_all('tr', class_='team')

            for equipo in equipos:
                nombre_equipo = equipo.find('td', class_='name').text.strip()
                año = equipo.find('td', class_='year').text.strip()
                victorias = equipo.find('td', class_='wins').text.strip()
                derrotas = equipo.find('td', class_='losses').text.strip()
                derrotas_tiempo_extra = equipo.find('td', class_='ot-losses').text.strip()                  
                porcentaje_victorias = equipo.find('td', class_='pct').text.strip()
                goles_favor = equipo.find('td', class_='gf').text.strip()
                goles_contra = equipo.find('td', class_='ga').text.strip()
                diferencia_goles = equipo.find('td', class_='diff').text.strip()
                    
                equipos_info.append([nombre_equipo, año, victorias, derrotas, derrotas_tiempo_extra, porcentaje_victorias, goles_favor, goles_contra, diferencia_goles])
            
            url_paginada = f"{url}?page_num={i+1}"

        with open('equiposBS.csv', 'w', newline='') as file:
                writer = csv.writer(file)
                writer.writerow(['Nombre del Equipo', 'Año', 'Victorias', 'Derrotas', 'Derrotas en tiempo extra', 'Porcentaje de victorias', 'Goles a favor', 'Goles en contra', 'Diferencia de goles'])
                writer.writerows(equipos_info)

   
        print("Scrap completado y datos guardados en equiposBS.csv")
        
        
class ScrapSelenium(EstrategiaScrap):
    def scrap(self, url):
        # Implementación del scrap utilizando Selenium
        print(f"Scrapeando {url} con Selenium")
        
        chrome_options = Options()
        driver = webdriver.Chrome(options=chrome_options)
        driver.get(url)
        
        equipos = []
        
        for i in range(5): # Queremos 5 páginas
            print(f"Analizando página {i+1} con Selenium...")
            time.sleep(5)
            
            filas = driver.find_elements(By.CLASS_NAME, 'team')

            for fila in filas:
                nombre_equipo = fila.find_element(By.CLASS_NAME, 'name').text.strip()
                año = fila.find_element(By.CLASS_NAME, 'year').text.strip()
                victorias = fila.find_element(By.CLASS_NAME, 'wins').text.strip()
                derrotas = fila.find_element(By.CLASS_NAME, 'losses').text.strip()
                derrotas_tiempo_extra = fila.find_element(By.CLASS_NAME, 'ot-losses').text.strip()
                porcentaje_victorias = fila.find_element(By.CLASS_NAME, 'pct').text.strip()
                goles_favor = fila.find_element(By.CLASS_NAME, 'gf').text.strip()
                goles_contra = fila.find_element(By.CLASS_NAME, 'ga').text.strip()
                diferencia_goles = fila.find_element(By.CLASS_NAME, 'diff').text.strip()

                equipos.append([nombre_equipo, año, victorias, derrotas, derrotas_tiempo_extra, porcentaje_victorias, goles_favor, goles_contra, diferencia_goles])

            boton_siguiente = driver.find_element(By.XPATH, "//a[@aria-label='Next']")
            boton_siguiente.click()
                
        driver.quit()
        
        with open('equiposSelenium.csv', 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(['Nombre del Equipo', 'Año', 'Victorias', 'Derrotas', 'Derrotas en tiempo extra', 'Porcentaje de victorias', 'Goles a favor', 'Goles en contra', 'Diferencia de goles'])
            writer.writerows(equipos)

        print("Scrap completado y datos guardados en equiposSelenium.csv")

class ContextoScrap:
    def __init__(self, estrategia: EstrategiaScrap):
        self._estrategia = estrategia
        
    def set_estrategia(self, estrategia: EstrategiaScrap):
        self._estrategia = estrategia
        
    def realizar_scrap(self, url):
        self._estrategia.scrap(url)