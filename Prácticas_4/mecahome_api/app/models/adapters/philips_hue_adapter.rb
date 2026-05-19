class Adapters::PhilipsHueAdapter < Adapters::DispositivoAdapter
  def encender
    "Philips Hue '#{@nombre}': LED encendido al 100% (turn_on_led)."
  end

  def apagar
    "Philips Hue '#{@nombre}': LED apagado por completo (turn_off_led)."
  end
end