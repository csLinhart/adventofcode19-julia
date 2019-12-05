using DelimitedFiles
inputData = readdlm("D05.txt", ',', Int)

function RunIntcode(input, initInp)
    i = 1
    while true
        code = parse.(Int, split(lpad(string(input[i]), 4, '0'), ""))
        opcode = code[end]
        p1 = code[2] == 1 ? input[i + 1] : input[input[i + 1] + 1]
        if (input[i + 2] + 1 <= length(input))
            p2 = code[1] == 1 ? input[i + 2] : input[input[i + 2] + 1]
        end
        if opcode == 1
            input[input[i + 3] + 1] = p1 + p2
            i = i + 4
        elseif opcode == 2
            input[input[i + 3] + 1] = p1 * p2
            i = i + 4
        elseif opcode == 3
            input[input[i + 1] + 1] = initInp
            i = i + 2
        elseif opcode == 4
            if (p1 != 0)
                println(p1)
                return
            end
            i = i + 2
        elseif opcode == 5
            i = (p1 != 0 ) ? p2 + 1 : i + 3
        elseif opcode == 6
            i = (p1 == 0 ) ? p2 + 1 : i + 3
        elseif opcode == 7
            input[input[i + 3] + 1] = (p1 < p2) ? 1 : 0
            i = i + 4
        elseif opcode == 8
            input[input[i + 3] + 1] = (p1 == p2) ? 1 : 0
            i = i + 4
        end
    end
end

RunIntcode(copy(inputData), 1)
RunIntcode(copy(inputData), 5)