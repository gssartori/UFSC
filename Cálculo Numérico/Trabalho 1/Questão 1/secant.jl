module sc

    include("root_keeper.jl")
    using .keeper: f, root_checker

    # Falsa-Posição, com os pontos iniciais de '0,6' e '1'
    sec = Dict( "root" => [],                       # Raízes da função
                "error" => [],                      # Erro de cada iteração
                "mid_pt" => [],                     # Pontos intermediários ((x1,y1), ..., (xn,yn))
                "count" => 0)                       # iteração atual/final do método
    
    fk(x0::Float64, x1::Float64) = x1 - ((x1-x0)*f(x1)) / (f(x1)-f(x0))

    function secant(x0::Float64, x1::Float64)
        global sec
        while sec["count"]<100 && sec["root"] == []
            f_x0, f_x1 = abs(f(x0)), abs(f(x1))

            if (f_x0 > f_x1) 
                x0,x1 = x1,x0 
            end

            x2 = fk(x0, x1)

            if abs(f(x2)) > f_x1
                x0 = x2
            else
                x0, x1 = x1, x2
            end
            
            error = abs(f(x1))
            root_checker(x1, x0, error, sec)
        end
    end
        
    secant(0.5, 0.7)
    # println("Secante: ", sec)

end