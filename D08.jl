inp = open(f->read(f, String), "D08.txt")
inputData = parse.(Int, split(inp,""))
layers = reshape(inputData, 25*6, :)'
ly = mapslices(x->[x], layers, dims=2)[:]

function FindFewestZeros(layers)
    noOfZeros = sum(x->x==0, layers, dims=2)
    index = argmin(noOfZeros)
    minLayer = layers[index[1],:]
    sum(x->x==2, minLayer) * sum(x->x==1, minLayer)
end
println(FindFewestZeros(layers))

function showMessage(layers)
    function CheckPixels(layer1, layer2)
        map(x -> x[2]==2 ? layer2[x[1]] : x[2], enumerate(layer1))
    end
    image = reduce(CheckPixels, layers)
    display(reshape(image, 25, 6)')
end
showMessage(ly)
