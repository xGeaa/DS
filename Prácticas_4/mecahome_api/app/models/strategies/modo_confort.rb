class Strategies::ModoConfort < Strategies::PoliticaClimatizacion
  def evaluar(temp_actual, temp_deseada)
    (temp_actual - temp_deseada).abs >= 0.5
  end
end