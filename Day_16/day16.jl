using Debugger

function corr_check(feild, rules)
  ret = false
  for i in 1:length(rules)
    ranges = match(r"(\d+-\d+) or (\d+-\d+)", rules[i]).captures

    for j in ranges
      low, up = split(j, "-")
      low = parse(Int, low)
      up = parse(Int, up)

      #println(low, " ", feild, " ", up)
      if (low <= feild[1] <= up)
        ret = true
      end

    end
  end

  return ret
end

function check_all(ticket, rules)
  t = split(ticket, ",")
  t = parse.(Int, t)

  res = Int64[]

  for i in t
    if !corr_check(i, rules)
      push!(res, i)
    end
  end

  return res
end


input = open("in16.csv")

inp = read(input, String)
rules, my_t, other_t = split(inp, "\n\n")

rules = split(rules, "\n")
other_t = split(other_t, "\n")

error = Int64[]

for i in other_t[2:end-1]
  append!(error, check_all(i, rules))
end

println("Error: ", error)
println("Error-rate: ", sum(error))
