class Strategies::ModoEco < Strategies::PoliticaClimatizacion
  def evaluar(temp_actual, temp_deseada)
    (temp_actual - temp_deseada).abs >= 2.0
  end
end