function corr_check2(feild, rules)
  ret = false
  ranges = match(r"(\d+-\d+) or (\d+-\d+)", rules).captures

  for j in ranges
    low, up = split(j, "-")
    low = parse(Int, low)
    up = parse(Int, up)

    #println(low, " ", feild, " ", up)
    if (low <= feild[1] <= up)
      ret = true
    end
  end
  return ret
end

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
      return false
    end
  end

  return true
end

input = open("in16.csv")

inp = read(input, String)
rules, my_t, other_t = split(inp, "\n\n")

rules = split(rules, "\n")
other_t = split(other_t, "\n")
zzz, my_t = split(my_t, "\n")
my_t = split(my_t, ",")

f_mat = [c for r in 1:length(rules), c in 1:length(split(other_t[2], ","))]

for i in 1:length(rules)
  for j in other_t[2:end-1]
    if check_all(j, rules)
      t = split(j, ",")
      t = parse.(Int, t)
      for k in 1:length(t)
        if !corr_check2(t[k], rules[i])
          f_mat[i, k] = 0
        end
      end
    end
  end
end

function min_m(m, fil)
  for i in 1:size(m, 1)
    local tmp = setdiff(f_mat[i, :], fil)
    if length(tmp) == 1
      return i, tmp
    end
  end
  println("Error")
end

f_vec = zeros(length(rules))
filt = [0]

for i in 1:length(f_vec)
  local j, tmp = min_m(f_mat, filt)
  f_vec[j] = tmp[1]
  global filt = union(filt, tmp)
end

f_vec = trunc.(Int, f_vec)

fin_res = 1
for i in f_vec[1:6]
  global fin_res *= parse(Int, my_t[i])
end

println("Mat: ", f_mat)
println("Vec: ", f_vec)
println("Res: ", fin_res)
