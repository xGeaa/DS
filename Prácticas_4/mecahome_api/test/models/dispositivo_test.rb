require "test_helper"

class DispositivoTest < ActiveSupport::TestCase
  # --- TESTS DEL PATRÓN ADAPTER ---
  test "debe retornar el adaptador correcto segun la marca" do
    dispositivo_philips = dispositivos(:luz_salon)
    dispositivo_xiaomi = dispositivos(:enchufe_cocina)

    # Añadimos Adapters:: aquí abajo
    assert_kind_of Adapters::PhilipsHueAdapter, dispositivo_philips.obtener_adaptador
    assert_kind_of Adapters::XiaomiPlugAdapter, dispositivo_xiaomi.obtener_adaptador
  end

  test "el adaptador de philips debe ejecutar su metodo nativo" do
    adapter = dispositivos(:luz_salon).obtener_adaptador
    assert_match(/turn_on_led/, adapter.encender)
  end

  # --- TESTS DEL PATRÓN STRATEGY ---
  test "el modo eco no debe encender si no se supera por 2 grados" do
    aire = dispositivos(:aire_acondicionado)
    aire.temperatura_actual = 23.5
    aire.modo_clima = "eco"
    
    assert_not aire.debe_encender_clima?
  end

  test "el modo eco si debe encender si se supera por 2 grados o mas" do
    aire = dispositivos(:aire_acondicionado)
    aire.temperatura_actual = 24.5
    aire.modo_clima = "eco"
    
    assert aire.debe_encender_clima?
  end

  test "el modo confort debe encender con solo medio grado de diferencia" do
    aire = dispositivos(:aire_acondicionado)
    aire.temperatura_actual = 22.6
    aire.modo_clima = "confort"
    
    assert aire.debe_encender_clima?
  end
  # --- TESTS DE ENTORNO COMPARTIDO Y SIMULACIÓN GLOBAL ---

    test "iluminacion global: cambiar la luminosidad de una bombilla debe sincronizar el resto" do
      Dispositivo.where(tipo: 'iluminacion').destroy_all

      b1 = Dispositivo.create!(nombre: "Luz Techo", tipo: "iluminacion", marca: "philips", estado: "off", luminosidad: 70)
      b2 = Dispositivo.create!(nombre: "Luz Lampara", tipo: "iluminacion", marca: "xiaomi", estado: "off", luminosidad: 70)

      b1.update!(luminosidad: 30)

      b2.reload

      assert_equal 30, b2.luminosidad
      assert_equal "on", b2.estado
      assert_equal "on", b1.estado
    end

    test "persianas globales: luminosidad alta debe cerrar todas las persianas" do
      Dispositivo.where(tipo: 'persiana').destroy_all

      p1 = Dispositivo.create!(nombre: "Persiana Salon", tipo: "persiana", marca: "xiaomi", estado: "on", luminosidad: 40)
      p2 = Dispositivo.create!(nombre: "Persiana Cuarto", tipo: "persiana", marca: "xiaomi", estado: "on", luminosidad: 40)

      p1.update!(luminosidad: 85)
      p2.reload

      assert_equal "on", p1.estado
      assert_equal "on", p2.estado
    end

    test "climatizacion global: dos aires encendidos deben sumar sus potencias (pasos)" do
      Dispositivo.where(tipo: 'climatizacion').destroy_all

      aire1 = Dispositivo.create!(nombre: "Aire 1", tipo: "climatizacion", marca: "nest", estado: "on", temperatura_actual: 25.0, temperatura_deseada: 21.0, modo_clima: "confort") # Confort resta 1.0
      aire2 = Dispositivo.create!(nombre: "Aire 2", tipo: "climatizacion", marca: "nest", estado: "on", temperatura_actual: 25.0, temperatura_deseada: 21.0, modo_clima: "eco")     # Eco resta 0.5

      aire1.reload
      aire2.reload

      assert_equal 23.5, aire1.temperatura_actual
      assert_equal 23.5, aire2.temperatura_actual
    end

    test "climatizacion de invierno: el aire debe encenderse para calentar si hace frio" do
      Dispositivo.where(tipo: 'climatizacion').destroy_all

      aire = Dispositivo.create!(nombre: "Calefactor", tipo: "climatizacion", marca: "nest", estado: "off", temperatura_actual: 15.0, temperatura_deseada: 21.0, modo_clima: "confort")



      assert_equal "on", aire.estado
      assert_equal 16.0, aire.temperatura_actual
    end
end