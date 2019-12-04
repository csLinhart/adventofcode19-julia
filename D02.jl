using DelimitedFiles
inputData = readdlm("D02.txt", ',', Int)

function RunIntcode(input, noun, verb)
    input[2:3] = [noun, verb]

    function Process(i, operator)
        input[input[i + 3] + 1] = foldl(operator, [input[input[i + 1] + 1], input[input[i + 2] + 1]])
    end

    for i = 1:4:length(input)
        opcode = input[i]
        if opcode == 1
            Process(i, +)
        elseif opcode == 2
            Process(i, *)
        elseif opcode == 99
            break
        end
    end
end

input = copy(inputData)
RunIntcode(input, 12, 2)
println(input[1])

function FindNounVerb(inp)
    for j = 0:99
        for k = 0:99
            input = copy(inp)
            RunIntcode(input, j, k)
            if input[1] == 19690720
                return (j * 100 + k)
            end
        end
    end
end
println(FindNounVerb(inputData))