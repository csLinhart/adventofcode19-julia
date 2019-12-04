using DelimitedFiles
input = readdlm("D01.txt", '\n', Int)

CalculateFuel(mass) = floor.(mass / 3) .- 2

println(sum(CalculateFuel(input)))

function CalculateFuelRecursive(mass)
    fuel = CalculateFuel(mass)
    (fuel <= 0) ? 0 : fuel + CalculateFuelRecursive(fuel)
end
println(sum(CalculateFuelRecursive.(input)))