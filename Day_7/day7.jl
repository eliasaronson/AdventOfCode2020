inp = open("in7.csv")

function find_gold(value, dict)

  n = 0
  for i in value
    if occursin(r"\d+ (shiny gold) bag", i)
      n +=  parse(Int, match(r"(\d+)", i).match)
    elseif !occursin(r"no other bag", i)
      key = match(r"(?<=\d |\d{2} )(.+)", i).match
      num_bags = parse(Int, match(r"(\d+)", i).match)
      n += num_bags * find_gold(dict[key], dict)
    end
  end

  return n
end

lines = readlines(inp)

dict = Dict()

for l in lines
  key, val = split(l, " contain ")
  key = replace(key, r"bags" => s"bag")
  val = replace(val, r"\." => s"")
  val = replace(val, r"bags" => s"bag")
  value = split(val, ", ")

  if haskey(dict, key)
    println("Warning")
  end

  dict[key] = value
end

println(dict)

n_gold = 0
for (key, value) in dict
  println(n_gold)
  if find_gold(value, dict) > 0
    global n_gold += 1
  end
end

println("Number of golden bags: ", n_gold)
