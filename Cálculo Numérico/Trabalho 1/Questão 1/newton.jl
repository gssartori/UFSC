module nw

    include("root_keeper.jl")
    using .keeper: f

    # Newton, com os ponto inicial de '0,6'
    new = Dict( "root" => [],                       # Raízes da função
                "error" => [],                      # Erro de cada iteração
                "mid_pt" => [],                     # Pontos intermediários ((x1,y1), ..., (xn,yn))
                "count" => 0)                       # iteração atual/final do método
    
    fl(x::Float64) = 12x^2-3+0.1ℯ^(-x)                    # f'(x)

    function newton(x::Float64)
        global new
        while abs(f(x)) > 10^-6 && new["count"]<100
            x -= f(x)/fl(x)

            push!(new["error"], f(x))
            push!(new["mid_pt"], (x, f(x)))
            new["count"]+=1
        end

        new["root"] = x
    end
        
    newton(0.6)
    # println("Newton: ", new)

end