module bs

    include("root_keeper.jl")
    using .keeper: f, root_checker

    # Bissecção, com os pontos iniciais de '0,6' e '1'
    bis = Dict( "root" => [],                       # Raízes da função
                "error" => [],                      # Erro de cada iteração
                "mid_pt" => [],                     # Pontos intermediários ((x1,y1), ..., (xn,yn))
                "count" => 0)                       # iteração atual/final do método
                

    function biseccion(a::Float64, b::Float64)
        global bis
        if (bis["count"] < 100 && bis["root"] == []) 
            if f(a)*f(b) < 0
                x = (a+b)/2
                error = abs(f(a)+f(b))

                if !root_checker(a, b, error, bis)
                    biseccion(a, x)
                    biseccion(x, b) 
                end
            end
        end
    end
        
    biseccion(0.6, 1.0)
    # println("BISECCION: ", bis)

end