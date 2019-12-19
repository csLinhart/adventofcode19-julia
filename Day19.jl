using DelimitedFiles
inputData = readdlm("D19.txt", ',', Int)

function RunIntcode(input, initInp)
    i = 1
    rb = 0
    p = zeros(Int, 1, 3)
    while true
        code = parse.(Int, split(lpad(string(input[i]), 5, '0'), ""))
        opcode = code[end - 1]  * 10 + code[end]
        for k = 1:3
            if code[4 - k] == 0
                p[k] = input[i + k] + 1
            elseif code[4 - k] == 1
                p[k] = i + k
            elseif code[4 - k] == 2
                p[k] = input[i + k] + 1 + rb
            end
        end
        if opcode == 1
            input[p[3]] = input[p[1]] + input[p[2]]
            i = i + 4
        elseif opcode == 2
            input[p[3]] = input[p[1]] * input[p[2]]
            i = i + 4
        elseif opcode == 3
            input[p[1]] = popfirst!(initInp)
            i = i + 2
        elseif opcode == 4
            return input[p[1]]
            i = i + 2
        elseif opcode == 5
            i = (input[p[1]] != 0 ) ? input[p[2]] + 1 : i + 3
        elseif opcode == 6
            i = (input[p[1]] == 0 ) ? input[p[2]] + 1 : i + 3
        elseif opcode == 7
            input[p[3]] = (input[p[1]] < input[p[2]]) ? 1 : 0
            i = i + 4
        elseif opcode == 8
            input[p[3]] = (input[p[1]] == input[p[2]]) ? 1 : 0
            i = i + 4
        elseif opcode == 9
            rb = rb + input[p[1]]
            i = i + 2
        elseif opcode == 99
            return
        end
    end
end

function CalculatePart1(inputData)
    largeMemory = zeros(Int, 1, 500)
    largeMemory[1:length(inputData)] = inputData
    count = 0
    for k = 0:49
        for l = 0:49
            result = RunIntcode(copy(largeMemory), [k, l])
            count += result
        end
    end
    count
end
println(CalculatePart1(inputData))

function CalculatePart2(inputData)
    largeMemory = zeros(Int, 1, 500)
    largeMemory[1:length(inputData)] = inputData
    for k = 800:1500
        for l = 800:1500
            if RunIntcode(copy(largeMemory), [k, l]) == 1
                if RunIntcode(copy(largeMemory), [k + 99, l]) == 1
                    if RunIntcode(copy(largeMemory), [k, l + 99]) == 1
                        return k * 10000 + l
                    end
                end
            end
        end
    end
end
println(CalculatePart2(inputData))
