inp = open("in13.csv")

input = readlines(inp)

t₀ = parse(Int, input[1])

ids = split(input[2], ",")
filter!(e -> e ≠ "x", ids)
ids = parse.(Int, ids)

times = Vector{Int}(undef, length(ids))

j = 1
for i in ids
  t = 0
  while t < t₀ 
    t += i
  end
  times[j] = t
  global j += 1
end

times = times .- t₀ 
t_min = minimum(times)
mins = findall(x -> x == t_min, times)

println("Wait time: ", t_min)
println("Buss ids with shortest wait: ", ids[mins])
println()
println(t_min * ids[mins[1]])
