using DelimitedFiles
include("IntCode.jl")
inputData = readdlm("D19.txt", ',', Int)

function CalculatePart1(inputData)
    count = 0
    for k = 0:49
        for l = 0:49
            result = RunIntcode(inputData, [k, l], true)
            count += result
        end
    end
    count
end
println(CalculatePart1(inputData))

function CalculatePart2(inputData)
    for k = 800:1400
        for l = 800:1400
            if RunIntcode(inputData, [k, l], true) == 1
                if RunIntcode(inputData, [k + 99, l], true) == 1
                    if RunIntcode(inputData, [k, l + 99], true) == 1
                        return k * 10000 + l
                    end
                end
            end
        end
    end
end
println(CalculatePart2(inputData))
