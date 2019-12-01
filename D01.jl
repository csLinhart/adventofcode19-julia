using DelimitedFiles
input = readdlm("D01.txt", '\t', Int, '\n')

function D1Logic(mass)
    floor(mass/3) -2
end

function D1P1(input)
    return mapreduce(D1Logic, +, input; init=0)
end
println(D1P1(input))

function D1P2(input)
    function D1P22(mass)
        fuel = D1Logic(mass)
        return (fuel <= 0) ? 0 : fuel + D1P22(fuel)
    end
    return mapreduce(D1P22, +, input; init=0)
end
println(D1P2(input))