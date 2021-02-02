end_turn = 30000000 #Part 2
#end_turn = 2020    #Part 1

inp = open("in15.csv")

start_n = read(inp, String)
start_n = split(start_n, ",")
start_n = parse.(Int, start_n)

println(start_n)

dict_n = Dict{Int, Int}()
l_start = length(start_n)

for i in 1:l_start-1
  dict_n[start_n[i]] = i
end
println(dict_n)

curr = start_n[end]
prev = start_n[end]
for i in (l_start+1):end_turn
  global prev = curr

  if haskey(dict_n, prev)
    global curr = i - 1 - dict_n[curr]
  else
    global curr = 0
  end

  dict_n[prev] = i - 1
end
println(curr)


