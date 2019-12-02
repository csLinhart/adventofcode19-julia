using DelimitedFiles
inputData = readdlm("D02.txt", ',', Int)

function RunIntcode(input, noun, verb)
    input[2:3] = [noun, verb]

    function Process(i, operator)
        input[input[i+3]+1] = foldl(operator, [input[input[i+1]+1], input[input[i+2]+1]])
    end

    for i=1:4:length(input)
        if input[i]==1
            Process(i, +)
        end
        if input[i]==2
            Process(i, *)
        end
        if input[i]==99
            break
        end
    end
end

input = copy(inputData)
RunIntcode(input, 12, 2)
println(input[1])

for j=0:99
    for k=0:99
        input = copy(inputData)
        RunIntcode(input, j, k)
        if input[1]==19690720
            println(j,k)
            return
        end
    end
end