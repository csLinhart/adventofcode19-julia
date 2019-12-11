using DelimitedFiles
using Combinatorics
inputData = readdlm("D07.txt", ',', Int)

function RunIntcode(input, initInp, ind)
    i = ind
    while true
        code = parse.(Int, split(lpad(string(input[i]), 4, '0'), ""))
        opcode = code[end-1] * 10 + code[end]
        if opcode == 99
            return (0, 0)
        end
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
            input[input[i + 1] + 1] = popfirst!(initInp)
            i = i + 2
        elseif opcode == 4
            return (p1, i + 2)
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

function CalculateMaxSignal(inputData, initInp)
    combinations = unique(collect(permutations([0 1 2 3 4], 5)))
    function CalculateE(comb)
        RunAmp(x, y) = RunIntcode(copy(inputData), [y, x[1]], 1)
        reduce(RunAmp, comb; init=initInp)
    end
    maximum(map(CalculateE, combinations))[1]
end
println(CalculateMaxSignal(inputData, 0))

function CalculateMaxSignalFeedback(inputData, initInp)
    combinations = unique(collect(permutations([5 6 7 8 9], 5)))
    function CalculateE(comb)
        inpA = inpB = inpC = inpD = inpE = copy(inputData);
        idA = idB = idC = idD = idE = 1;
        (a, idA) = RunIntcode(inpA, [comb[1], initInp], idA)
        (b, idB) = RunIntcode(inpB, [comb[2], a], idB)
        (c, idC) = RunIntcode(inpC, [comb[3], b], idC)
        (d, idD) = RunIntcode(inpD, [comb[4], c], idD)
        (e, idE) = RunIntcode(inpE, [comb[5], d], idE)
        while true
            (a, idA) = RunIntcode(inpA, [e], idA)
            if (idA==0)
                break
            end
            (b, idB) = RunIntcode(inpB, [a], idB)
            (c, idC) = RunIntcode(inpC, [b], idC)
            (d, idD) = RunIntcode(inpD, [c], idD)
            (e, idE) = RunIntcode(inpE, [d], idE)
        end
        e
    end
    maximum(map(CalculateE, combinations))[1]
end
println(CalculateMaxSignalFeedback(inputData, 0))
