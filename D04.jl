inp1 = 278384
inp2 = 824795

function IsValidPwd(nmb, part2)
    n = digits(nmb)[end:-1:1]
    g = false
    counter = 0
    lastnum = -1
    for j = 1:length(n)
        num = n[j]
        if num < lastnum
            return false
        end
        if (part2)
            if (num != lastnum && counter == 1)
                g = true
            end
            counter = num == lastnum ? counter + 1 : 0
        elseif num == lastnum
            g = true
        end
        lastnum = num
    end
    g || counter == 1
end

function CountValidPwds(inp1, inp2)
    (length(filter(y->IsValidPwd(y, false), inp1:inp2)), length(filter(x->IsValidPwd(x, true), inp1:inp2)))
end

result = CountValidPwds(inp1, inp2)
println(result)