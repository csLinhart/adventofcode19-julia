using DelimitedFiles
inputData = readdlm("D09.txt", ',', Int)

function RunIntcode(input, initInp)
    i = 1
    rb = 0
    p = Int.(zeros(1, 3))
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
            input[p[1]] = initInp
            i = i + 2
        elseif opcode == 4
            if (p[1] != 0)
                println(input[p[1]])
            end
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

largeMemory = Int.(zeros(1, 1100))
largeMemory[1:length(inputData)] = inputData
RunIntcode(copy(largeMemory), 1)
RunIntcode(copy(largeMemory), 2)