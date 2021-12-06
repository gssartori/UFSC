module fp

    include("root_keeper.jl")
    using .keeper: f, root_checker

    # Falsa-Posição, com os pontos iniciais de '0,6' e '1'
    fps = Dict( "root" => [],                       # Raízes da função
                "error" => [],                      # Erro de cada iteração
                "mid_pt" => [],                     # Pontos intermediários ((x1,y1), ..., (xn,yn))
                "count" => 0)                       # iteração atual/final do método
    
    DIGSE(Xs::Float64, Xa::Float64) = log(abs(Xs-Xa)/Xa)

    function false_pos(a::Float64, b::Float64)
        global fps
        if (fps["count"] < 100 && fps["root"] == []) 
            xs = a - (b-a)*f(a) / (f(b)-f(a))
            error = abs( DIGSE(xs, a) - DIGSE(a, xs))

            (f(xs)*f(a) < 0) ? b = xs : a = xs
            
            root_checker(a, b, error, fps)
            false_pos(a, b)
        end
    end
        
    false_pos(0.6, 1.0)
    # println("False Position: ", fps)

end