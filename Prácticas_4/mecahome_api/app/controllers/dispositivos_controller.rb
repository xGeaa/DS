class DispositivosController < ApplicationController
  # GET /dispositivos (Leer todos)
  def index
    @dispositivos = Dispositivo.all
    render json: @dispositivos
  end

  # GET /dispositivos/:id (Leer uno solo)
  def show
    @dispositivo = Dispositivo.find(params[:id])
    render json: @dispositivo
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Dispositivo no encontrado" }, status: :not_found
  end

  # POST /dispositivos (Crear uno nuevo)
  def create
    @dispositivo = Dispositivo.new(dispositivo_params)
    if @dispositivo.save
      render json: @dispositivo, status: :created
    else
      render json: @dispositivo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dispositivos/:id (Actualizar)
  def update
    @dispositivo = Dispositivo.find(params[:id])
    if @dispositivo.update(dispositivo_params)
      render json: @dispositivo
    else
      render json: @dispositivo.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Dispositivo no encontrado" }, status: :not_found
  end

  # DELETE /dispositivos/:id (Borrar)
  def destroy
    @dispositivo = Dispositivo.find(params[:id])
    @dispositivo.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Dispositivo no encontrado" }, status: :not_found
  end

  private

  # Permisos estrictos de Rails para evitar inyecciones maliciosas
  def dispositivo_params
    params.require(:dispositivo).permit(:nombre, :tipo, :marca, :estado, :temperatura_actual, :temperatura_deseada, :modo_clima, :luminosidad)
  end
end

