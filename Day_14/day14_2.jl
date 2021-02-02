function sum_dict(dict)
  ret = 0
  for (key, value) in dict
    ret += value
  end
  return ret
end

function vec_to_int(val_vec)
  ret = ""
  for i in val_vec
    ret = ret * i
  end
  ret = parse(Int, ret, base = 2)

  return ret
end

function genAllBinComb(n, arr, i, ret_vec, X)
  if (i > n)
    append!(ret_vec, vec_to_int(arr))
    return
  end

  arr[X[i]] = "0"
  genAllBinComb(n, arr, i+1, ret_vec, X)

  arr[X[i]] = "1"
  genAllBinComb(n, arr, i+1, ret_vec, X)
end

function mask_func(val, mask)
  val = string(val, base = 2)
  val = repeat("0", 36-length(val)) * val

  val_vec = split(val, "")
  for i in findall("1", mask)
    val_vec[i[1]] = "1"
  end

  for i in findall("X", mask)
    val_vec[i[1]] = "X"
  end

  X = findall(isequal("X"), val_vec)

  ret_vec = Int64[]

  genAllBinComb(length(X), val_vec, 1, ret_vec, X)

  return ret_vec

end

function write(pos, val, mask, memo)
  for i in mask_func(pos, mask)
    memo[i] = val  
  end
end

# Start
inp = open("in14.csv")

input = readlines(inp)

mask = ""
memo = Dict()

for i in input
  local comm = match(r"^(\w+)", i).match
  if comm == "mask"
    global mask = match(r"(?<== )(\w+)", i).match
  elseif comm == "mem"
    write(parse(Int, match(r"\[(\w+)\]", i).captures[1]), parse(Int, match(r"(?<== )(\w+)", i).captures[1]), mask, memo)
  else
    println("Error")
  end
end

println(sum_dict(memo))
println(mask)
