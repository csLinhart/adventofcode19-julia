using DelimitedFiles
input = readdlm("D01.txt", '\n', Int)

CalculateFuel(mass) = floor.(mass/3) .- 2

println(sum(CalculateFuel(input)))

function D1P2(mass)
    fuel = CalculateFuel(mass)
    (fuel <= 0) ? 0 : fuel + D1P2(fuel)
end
println(sum(D1P2.(input)))
