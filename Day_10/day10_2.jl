inp = open("in10.csv")

input = readlines(inp)

input = parse.(Int, input) 

push!(input, 0)
push!(input, maximum(input)+3)

adapters = sort(input; rev=true)
println(adapters)

println("Diff vect: \n", diff)

function combi(adapters)
  combs = Dict(first(adapters) => 1)
  for j in adapters[2:end]
    combs[j] = sum(get(combs, j+i, 0) for i in 1:3)
  end
  return combs[0]
end

println("Res: ", combi(adapters))
