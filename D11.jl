using DelimitedFiles, Plots
plotly()
inputData = readdlm("D11.txt", ',', Int)

function RunIntcode(input, startPixel)
    i = 1
    rb = 0
    p = Int.(zeros(1, 3))
    M = zeros(1000, 1000)
    MC = copy(M)
    pos = [500, 500]
    M[pos[1], pos[2]] = startPixel
    dir = [1, 0]
    step = false
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
            input[p[1]] = M[pos[1], pos[2]] 
            i = i + 2
        elseif opcode == 4
            if (!step)
                M[pos[1], pos[2]] = input[p[1]]
                MC[pos[1], pos[2]] = 1
                step = true
            else
                if input[p[1]] == 0
                    dir = [0 -1; 1 0] * dir
                elseif input[p[1]] == 1
                    dir = [0 1; -1 0] * dir
                end
                pos = pos + dir
                step = false
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
            display(heatmap(M[:,end:-1:1], c = :greys))
            return sum(MC)
        end
    end
end

largeMemory = Int.(zeros(1, 2000))
largeMemory[1:length(inputData)] = inputData
println(RunIntcode(copy(largeMemory), 0))
RunIntcode(copy(largeMemory), 1)
