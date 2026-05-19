class Adapters::DispositivoAdapter
  attr_accessor :nombre

  def initialize(nombre)
    @nombre = nombre
  end

  def encender
    raise NotImplementedError, "Este método debe ser implementado por la subclase"
  end

  def apagar
    raise NotImplementedError, "Este método debe ser implementado por la subclase"
  end
end