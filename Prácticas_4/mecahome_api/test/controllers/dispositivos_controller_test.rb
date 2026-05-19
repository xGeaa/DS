require "test_helper"

class DispositivosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dispositivo = dispositivos(:luz_salon)
  end

  # READ (Index)
  test "should get index" do
    get dispositivos_url, as: :json
    assert_response :success
  end

  # CREATE
  test "should create dispositivo" do
    assert_difference("Dispositivo.count") do
      post dispositivos_url, params: { dispositivo: { nombre: "Nueva Lampara", tipo: "iluminacion", marca: "philips", estado: "off" } }, as: :json
    end
    assert_response :created
  end

  # READ (Show)
  test "should show dispositivo" do
    get dispositivo_url(@dispositivo), as: :json
    assert_response :success
  end

  # UPDATE
  test "should update dispositivo" do
    patch dispositivo_url(@dispositivo), params: { dispositivo: { estado: "on" } }, as: :json
    assert_response :success
    @dispositivo.reload
    assert_equal "on", @dispositivo.estado
  end

  # DELETE
  test "should destroy dispositivo" do
    assert_difference("Dispositivo.count", -1) do
      delete dispositivo_url(@dispositivo), as: :json
    end
    assert_response :no_content
  end
end