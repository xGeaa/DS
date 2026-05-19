class Strategies::ModoEco < Strategies::PoliticaClimatizacion
  def evaluar(temp_actual, temp_deseada)
    temp_actual >= (temp_deseada + 2.0)
  end
end