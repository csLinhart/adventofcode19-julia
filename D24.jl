inputData = map(collect, readlines("D24.txt"))
inputData = permutedims(hcat(inputData...))

function RunBugs(grid)
    layout = Array{Char}[]
    while true
        cop = copy(grid)
        for j = 1:length(cop[1,:])
            for i = 1:length(cop[:,1])
                count = 0
                if i + 1 <= length(cop[:,1]) && cop[i + 1, j] == '#'
                    count += 1
                end
                if i > 1 && cop[i - 1, j] == '#'
                    count += 1
                end
                if j + 1 <= length(cop[1, :]) && cop[i, j + 1] == '#'
                    count += 1
                end
                if j > 1 && cop[i, j - 1] == '#'
                    count += 1
                end
                if cop[i, j] == '#' && count != 1
                    grid[i, j] = '.'
                elseif cop[i, j] == '.' && (count == 1 || count == 2)
                    grid[i, j] = '#'
                end
            end
        end
        if findfirst(isequal(grid), layout) != nothing
            return grid
        end
        push!(layout, copy(grid))
    end
end

function PartOne(inputData)
    grid = RunBugs(inputData)
    F = findall(isequal('#'), grid)
    L = LinearIndices(grid')'
    result = sum(2 .^ (L[F] .- 1))
end
println(PartOne(inputData))
