class Adapters::XiaomiPlugAdapter < Adapters::DispositivoAdapter
  def encender
    "Xiaomi Plug '#{@nombre}': Relé activado -> Estado: 1 (set_power_status)."
  end

  def apagar
    "Xiaomi Plug '#{@nombre}': Relé desactivado -> Estado: 0 (set_power_status)."
  end
end