module Autenticacion

    AuthRequest = Struct.new(:email, :password)

    module Filtro
        def execute(request)
            raise NotImplementedError, "La clase #{self.class} debe implementar el metodo 'execute'"
        end
    end

    class FiltroPrefijoEmail
        include Filtro

        def execute(request)
            if request.email.match?(/^.+@/)
                true
            else
                puts "Error: Debe contener texto antes de @"
                false
            end
        end
    end

    class FiltroDominioEmail
        include Filtro

        def execute(request)
            if request.email.match?(/@(gmail\.com|hotmail\.com)$/)
                true
            else
                puts "[Email] Error: El dominio debe ser 'gmail.com' o 'hotmail.com'"
                false
            end
        end
    end

    class FiltroLongitudPassword
        include Filtro

        def execute(request)
            if request.password.length >= 8
                true
            else
                puts "[Contraseña] Error: Debe tener al menos 8 caracteres"
                false
            end
        end
    end

    class FiltroMayusculaPassword
        include Filtro

        def execute(request)
            if request.password.match?(/[A-Z]/)
                true
            else
                puts "[Contraseña] Error: Debe contener al menos una letra mayúscula."
                false
            end
        end
    end

    class FiltroNumeroPassword
        include Filtro
        def execute(request)
            if request.password.match?(/[0-9]/)
                true
            else
                puts "[Contraseña] Error: Debe contener al menos un número."
                false
            end
        end
    end

    class Target
        def execute(request)
            puts "[ÉXITO] Autenticación correcta para: #{request.email}"
        end
    end

    class FilterChain
        def initialize
            @filtros = []
            @target = nil
        end

        def add_filter(filtro)
            @filtros << filtro
        end

        def set_target(target)
            @target = target
        end

        def execute(request)
            @filtros.each do |filtro|
                return false unless filtro.execute(request)
            end
            @target.execute(request)
            true
        end
    end

    class FilterManager
        def initialize(target)
            @cadena = FilterChain.new
            @cadena.set_target(target)
        end

        def add_filter(filtro)
            @cadena.add_filter(filtro)
        end

        def filter_request(request)
            @cadena.execute(request)
        end
    end

    class Client
        def initialize(gestor)
            @gestor = gestor
        end

        def send_request(request)
            puts "\n--- Procesando Autenticación ---"
            @gestor.filter_request(request)
        end
    end

end
