using DelimitedFiles
include("IntCode.jl")
inputData = readdlm("D21.txt", ',', Int)

instruction1 = "NOT A T\nNOT B J\nOR T J\nNOT C T\nOR T J\nAND D J\nWALK\n"
println(RunIntcode(inputData, Int.(Vector{Char}(instruction1)))[end])

instruction2 = "NOT A T\nNOT B J\nOR T J\nNOT C T\nOR T J\nAND D J\nNOT D T\nOR H T\nOR E T\nAND T J\nRUN\n"
println(RunIntcode(inputData, Int.(Vector{Char}(instruction2)))[end])
