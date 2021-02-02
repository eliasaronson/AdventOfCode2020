inp = open("in14.csv")

input = readlines(inp)
println(input)

mask = ""
memo = Vector{Int}(undef, 999999)
fill!(memo, 0)

function mask_func(val, mask)
  val = string(val, base = 2)
  val = repeat("0", 36-length(val)) * val

  
  val_vec = split(val, "")
  for i in findall("1", mask)
    val_vec[i[1]] = "1"
  end

  for i in findall("0", mask)
    val_vec[i[1]] = "0"
  end

  ret = ""
  for i in val_vec
    ret = ret * i
  end
  ret = parse(Int, ret, base = 2)

  return ret
end

function write(pos, val, mask, memo)
  memo[pos] = mask_func(val, mask)
end

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

println(sum(memo))
println(mask)
