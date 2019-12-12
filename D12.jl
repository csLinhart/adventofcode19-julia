input = [14 2 8; 7 4 10; 1 17 16; -4 -1 1]

function CalculatePositions(P, v)
    set  = Set{Int64}()
    for j = 1:length(P[:,1])
        for k = 1:length(P[:,1])
            if j != k && !in(10 * j + k, set)
                for l = 1:length(P[j,:])
                    if P[j, l] > P[k, l]
                        v[j, l] = v[j, l] - 1
                        v[k, l] = v[k, l] + 1
                    elseif P[j, l] < P[k, l]
                        v[j, l] = v[j, l] + 1
                        v[k, l] = v[k, l] - 1
                    end
                end
            end
            push!(set, 10 * j + k)
            push!(set, 10 * k + j)
        end
    end
    P = P + v
    (P, v)
end

function CalculateEnergy(P)
    v = zeros(4, 3)
    for i = 1:1000
        (P, v) = CalculatePositions(P, v)
    end
    result = 0
    for j = 1:length(P[:,1])
        result = result + sum(abs.(P[j,:])) * sum(abs.(v[j,:]))
    end
    result
end
println(CalculateEnergy(input))

function CalculateSamePos(input)
    perm = [[1 3], [1 2], [2 3]]
    steps = Int.(zeros(3))
    for j = 1:length(perm)
        i = 1
        P = copy(input)
        Pi = copy(input)
        v = zeros(4, 3)
        vi = zeros(4, 3)
        P[:,perm[j][1]].=0; P[:,perm[j][2]].=0
        Pi[:,perm[j][1]].=0; Pi[:,perm[j][2]].=0
        while true
            (P, v) = CalculatePositions(P, v)
            if P == Pi && v == vi
                steps[j] = i
                break
            end
            i = i + 1
        end
    end
    lcm(steps)
end
println(CalculateSamePos(input))
