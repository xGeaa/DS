class Dispositivo < ApplicationRecord
  # 1. Añadimos este disparador automático antes de guardar en la BD
  before_save :simular_climatizacion, if: :necesita_simulacion?

  # Método para obtener el adaptador correcto según la marca guardada en la BD
  def obtener_adaptador
    case marca.downcase
    when 'philips'
      Adapters::PhilipsHueAdapter.new(nombre)
    when 'xiaomi'
      Adapters::XiaomiPlugAdapter.new(nombre)
    else
      raise "Marca no soportada"
    end
  end

  # Método para obtener la estrategia de clima correcta según el modo guardado en la BD
  def obtener_estrategia_clima
    case modo_clima&.downcase
    when 'eco'
      Strategies::ModoEco.new
    when 'confort'
      Strategies::ModoConfort.new
    when 'vacaciones'
      Strategies::ModoVacaciones.new
    else
      nil
    end
  end

  def debe_encender_clima?
    return false unless tipo.downcase == 'climatizacion'
    
    estrategia = obtener_estrategia_clima
    return false if estrategia.nil?

    estrategia.evaluar(temperatura_actual, temperatura_deseada)
  end

  private

  # Filtro para saber si cumple las condiciones de simulación
  def necesita_simulacion?
    tipo.downcase == 'climatizacion' && estado.downcase == 'on' && !temperatura_actual.nil? && !temperatura_deseada.nil?
  end

  # 2. Simula el cambio de temperatura real usando el Patrón Strategy
  def simular_climatizacion
    if debe_encender_clima?
      # Dependiendo del modo (estrategia), el "paso" de cambio será diferente
      paso = case modo_clima.downcase
             when 'eco'        then 0.5  # Cambia lento para ahorrar energía
             when 'confort'    then 1.0  # Cambia a velocidad normal
             when 'vacaciones' then 3.0  # Cambia radicalmente (ej: modo forzado/seguridad)
             else 0.0
             end

      # Si la casa está caliente, enfriamos. Si está fría, calentamos.
      if temperatura_actual > temperatura_deseada
        self.temperatura_actual = (temperatura_actual - paso).round(1)
      elsif temperatura_actual < temperatura_deseada
        self.temperatura_actual = (temperatura_actual + paso).round(1)
      end
    end
  end
end