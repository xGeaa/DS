class Dispositivo < ApplicationRecord
  # Disparadores automáticos antes de guardar en la BD
  before_save :simular_climatizacion, if: :es_climatizacion?
  before_save :automatizar_iluminacion, if: :es_iluminacion?
  before_save :automatizar_persiana, if: :es_persiana?

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
    estrategia = obtener_estrategia_clima
    return false if estrategia.nil?

    estrategia.evaluar(temperatura_actual, temperatura_deseada)
  end

  private

  def es_climatizacion?
    tipo.downcase == 'climatizacion'
  end

  def es_iluminacion?
    tipo.downcase == 'iluminacion'
  end

def es_persiana?
  tipo.downcase == 'persiana'
end

def automatizar_persiana
  return if luminosidad.nil?

  nuevo_estado = luminosidad >= 80 ? 'on' : 'off'
  self.estado = nuevo_estado

  persianas = Dispositivo.where(tipo: 'persiana')
  persianas = persianas.where.not(id: id) if id.present?
  persianas.update_all(luminosidad: luminosidad, estado: nuevo_estado)
end


  def automatizar_iluminacion
    return if luminosidad.nil?

    # Determinamos el estado según el umbral global
    nuevo_estado = luminosidad < 50 ? 'on' : 'off'
    self.estado = nuevo_estado

    # Buscamos el resto de bombillas y las actualizamos en lote masivo (update_all)
    # Usamos update_all porque modifica la BD directamente saltándose los callbacks, evitando bucles infinitos.
    bombillas = Dispositivo.where(tipo: 'iluminacion')
    bombillas = bombillas.where.not(id: id) if id.present?
    bombillas.update_all(luminosidad: luminosidad, estado: nuevo_estado)
  end

  # ❄️ SOLUCIÓN GLOBAL: Suma las potencias de todos los aires encendidos y aplica el cambio a todos
  def simular_climatizacion
    return if temperatura_actual.nil? || temperatura_deseada.nil?

    # 1. Evaluamos si ESTE aire debe encenderse o apagarse
    self.estado = debe_encender_clima? ? 'on' : 'off'

    # 2. Recopilamos todos los aires que van a estar encendidos ('on') en este instante
    aires_on = Dispositivo.where(tipo: 'climatizacion', estado: 'on')
    aires_on = aires_on.where.not(id: id) if id.present? # Excluimos el registro actual de la BD
    aires_on = aires_on.to_a
    aires_on << self if self.estado == 'on' # Añadimos el actual si se va a encender

    # 3. ¡Aquí está tu lógica! Sumamos el "paso" (potencia) de TODOS los aires que estén encendidos
    paso_total = 0.0
    aires_on.each do |aire|
      paso_total += case aire.modo_clima&.downcase
                    when 'eco'        then 0.5
                    when 'confort'    then 1.0
                    when 'vacaciones' then 3.0
                    else 0.0
                    end
    end

    # 4. Si hay aires encendidos trabajando juntos, alteramos la temperatura común de la casa
    if paso_total > 0
      nueva_temp = temperatura_actual
      if temperatura_actual > temperatura_deseada
        nueva_temp = (temperatura_actual - paso_total).round(1)
      elsif temperatura_actual < temperatura_deseada
        nueva_temp = (temperatura_actual + paso_total).round(1)
      end

      # 5. Forzamos a que TODOS los aires de la casa adopten la nueva temperatura ambiente
      self.temperatura_actual = nueva_temp
      aires_restantes = Dispositivo.where(tipo: 'climatizacion')
      aires_restantes = aires_restantes.where.not(id: id) if id.present?
      aires_restantes.update_all(temperatura_actual: nueva_temp)
    end
  end
end