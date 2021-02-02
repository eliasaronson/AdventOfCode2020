inp = open("in10.csv")

input = readlines(inp)

input = parse.(Int, input) 

push!(input, 0)
push!(input, maximum(input)+3)

adapters = sort(input)
println(adapters)

diff_1 = Vector{Int}(undef, length(adapters)-1)
for i in 1:(length(adapters)-1)
  diff_1[i] = adapters[i+1] - adapters[i]
end

println("Diff vect: \n", diff_1)

diff_counts = Dict{Int, Int}()

for d in diff_1
    diff_counts[d] = get(diff_counts, d, 0) + 1
end

println()
println("Diff counts: \n", diff_counts)

res = diff_counts[1] * diff_counts[3]
println()
println(res)
