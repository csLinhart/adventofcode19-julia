using DelimitedFiles
include("IntCode.jl")
inputData = readdlm("D13.txt", ',', Int)

output = RunIntcode(inputData, 0)
output = reshape(output, 3, :)'
tileIds = output[:,3]
println(length(tileIds[tileIds .== 2]))
