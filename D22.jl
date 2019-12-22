using DelimitedFiles
inputData = readdlm("D22.txt", '\n', String)
inputData = split.(inputData, " ")

function ShuffleCards(inputData, cards)
    function Shuffle(cards, inst)
        if inst[1] == "cut"
            cut = parse(Int, inst[2])
            cards = cut > 0 ? append!(cards[cut + 1:end], cards[1:cut]) : append!(cards[end + cut + 1:end], cards[1:end + cut])
        elseif inst[2] == "into"
            cards = reverse(cards)
        elseif inst[2] == "with"
            inc = parse(Int, inst[4])
            ind = 1
            cop = copy(cards)
            for j = 1:length(cop)
                cards[ind] = cop[j]
                ind += inc
                ind -= ind > length(cards) ? length(cards) : 0
            end
        end
        cards
    end
    cards = reduce(Shuffle, inputData; init = cards)
end
cards = collect(0:10006)
cards = ShuffleCards(inputData, cards)
println(findfirst(isequal(2019), cards) - 1)
