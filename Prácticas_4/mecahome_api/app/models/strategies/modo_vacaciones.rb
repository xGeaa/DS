class Strategies::ModoVacaciones < Strategies::PoliticaClimatizacion
  def evaluar(temp_actual, temp_deseada)
    temp_actual >= (temp_deseada + 10.0)
  end
end