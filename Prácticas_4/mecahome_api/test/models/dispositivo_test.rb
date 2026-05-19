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
end