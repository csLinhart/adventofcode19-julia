using DelimitedFiles
input = readdlm("D01.txt", '\n', Int)

function CalculateFuel(mass)
    floor(mass/3) - 2
end

println(mapreduce(CalculateFuel, +, input; init=0))

function D1P2(mass)
    fuel = CalculateFuel(mass)
    return (fuel <= 0) ? 0 : fuel + D1P2(fuel)
end
println(mapreduce(D1P2, +, input; init=0))