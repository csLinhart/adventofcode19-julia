using DelimitedFiles
inputData = readdlm("D17.txt", ',', Int)

function RunIntcode(input, initInp)
    i = 1
    rb = 0
    p = zeros(Int, 1, 3)
    k = l = 1
    M = zeros(Int, 55, 49)
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
            if (input[p[1]] == 35)
                M[k, l] = 1
                k += 1
            elseif (input[p[1]] == 46)
                k += 1
            elseif (input[p[1]] == 10)
                k = 1
                l += 1
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
            count = 0
            for m = 2:length(M[:,1]) - 1
                for n = 2:length(M[1,:]) - 1
                    if M[m,n] == 1 && M[m - 1,n] == 1 && M[m,n - 1] == 1 && M[m + 1,n] == 1 && M[m,n + 1] == 1
                        count += (m - 1) * (n - 1)
                    end
                end
            end
            return count
        end
    end
end

largeMemory = zeros(Int, 1, 5000)
largeMemory[1:length(inputData)] = inputData
println(RunIntcode(copy(largeMemory), [1]))
