using DelimitedFiles
include("IntCode.jl")
inputData = readdlm("D09.txt", ',', Int)

println(RunIntcode(inputData, [1])[end])
println(RunIntcode(inputData, [2])[end])
