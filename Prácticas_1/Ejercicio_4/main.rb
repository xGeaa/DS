
require_relative 'autenticacion'

target = Autenticacion::Target.new
gestor = Autenticacion::FilterManager.new(target)

gestor.add_filter(Autenticacion::FiltroPrefijoEmail.new)
gestor.add_filter(Autenticacion::FiltroDominioEmail.new)
gestor.add_filter(Autenticacion::FiltroLongitudPassword.new)
gestor.add_filter(Autenticacion::FiltroMayusculaPassword.new)
gestor.add_filter(Autenticacion::FiltroNumeroPassword.new)

cliente = Autenticacion::Client.new(gestor)

puts "=== INICIO DE SESIÓN SEGURO ==="
print "Correo electrónico: "
email = gets.chomp

print "Contraseña: "
password = gets.chomp

peticion = Autenticacion::AuthRequest.new(email, password)
cliente.send_request(peticion)