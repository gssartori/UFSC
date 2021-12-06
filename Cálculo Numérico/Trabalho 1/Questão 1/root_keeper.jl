# Considerando a função:
## f(x) = 4x³-3x-0.1e^(-x)
module keeper

    f(x::Float64) = 4x^3-3x-0.1ℯ^(-x)

    ε = 10^-6
    function root_checker(a::Float64, b::Float64, error::Float64, method::AbstractDict)
        """ 
            Função verifica se f(x)=0 ou se satisfaz os requisitos de aproximação.
            Caso seja, adiciona a raiz encontrada e cria um array com todos os erros 
            obtidos nas iterações anteriores comparado com a nova raiz encontrada.
        """ 
        method["count"] += 1

        for n in map(x -> round(x, digits=6), [a,b])
            if (n, f(n)) ∉ method["mid_pt"]
                push!(method["mid_pt"], (n, f(n)))
                push!(method["error"], error)
            end

            if (abs(f(n)) <= ε) || error <= ε
                push!(method["root"], n)
                # println("!!!! RAIZ ENCONTRADA !!!!     ::", n)
                # method["error"] = [broadcast(abs, x .-f(n)) for x in method["error"]]
                return true
            end
        end

        return false
    end

end

git init
git commit -m "Qestão 1 do 1° trabalho de Cálculo Numérico"
git branch -M main
git remote add "Questão 1" origin https://github.com/gssartori/UFSC/Cálculo Numérico/Trabalho 1.git
git push -u origin main

echo "# UFSC" >> README.md
git init
git add README.md
git commit -m "Qestão 1 do 1° trabalho de Cálculo Numérico"
git branch -M main
git remote add origin https://github.com/gssartori/UFSC/'Cálculo Numérico'/'Trabalho1'.git
git push -u origin main