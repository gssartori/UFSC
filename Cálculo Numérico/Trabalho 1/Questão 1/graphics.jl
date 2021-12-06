include("root_keeper.jl")
include("biseccion.jl")
include("falsePos.jl")
include("newton.jl")
include("secant.jl")

using Plots
using .keeper: f

function get_gradient(count::Int)
    grad = []
    for i in 0:count-1
        s = uppercase(string(floor(Int, 65280*(1-1/count*i)); base=16))
        push!(grad , "#"*s*"00")
    end
    return grad
end

# Intervalos para análise
x_min, x_max = .4, 1.1

function plot_creator(method, title)
    grad_color = get_gradient(method["count"])

    plt = plot(f, x_min, x_max, title=title)
    plot!(zero, x_min, x_max, lw=2, color="red")

    for (i, point) in enumerate(method["mid_pt"])
        if (x_min <= point[1] <= x_max) 
            scatter!(point, color=grad_color[i], markersize=5) 
        end
    end
    return plt
end


p_bs = plot_creator(bs.bis, "Biseccion")           # BISECCION
p_fp = plot_creator(fp.fps, "False Position")      # FALSE POSITION
p_nw = plot_creator(nw.new, "Newton")              # NEWTON
p_sc = plot_creator(sc.sec, "Secant")              # SECANT

plot(p_bs, p_fp, p_nw, p_sc, layout = (2,2), legend=false)

### ERROS ###

# plot(bis["error"], color="grey", lw=2)
# plot!(fps["error"], color="orange", lw=2)
# plot!(new["error"], color="blue", lw=2)
# plot!(sec["error"], color="purple", lw=2)

# scatter!((bis["count"], 0), color="grey", lw=3)
# scatter!((fps["count"], 0), color="orange", lw=3)
# scatter!((new["count"], 0), color="blue", lw=3)
# scatter!((sec["count"], 0), color="purple", lw=3)
