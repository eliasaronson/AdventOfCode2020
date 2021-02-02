function find_matches(t1, t2)
  t1_vec = [t1[1, :], t1[:, end], t1[end, :], t1[:, 1]]
  t2_vec = [t2[1, :], t2[:, end], t2[end, :], t2[:, 1]]
  println(t1_vec)
  println(t2_vec)

  ret = Array{Int64}[]
  for (indx1, i) in enumerate(t1_vec)
    for (indx2, j) in enumerate(t2_vec)
      if i == j
        push!(ret, [indx1, indx2])
      elseif i == j[end:-1:1,end:-1:1]
        push!(ret, [indx1, -indx2])
      end
    end
  end
  println("No match")
  return ret
end

function to_matrix(arr)

  ret = Array{Char}(undef, length(arr[1]), length(arr))

  for i in arr
    for j in 1:length(arr)
      ret[i, j] = arr[i, j]
    end
  end
  return ret
end

mutable struct Tile
  ID::Int64
  tile::Matrix{Char}
end

input = open("in20_t1.csv")
inp = read(input, String)

inp = split(inp, "\n\n")
tiles = Array{Tile, 1}(undef, length(inp))

for i in inp
  i = split(i, "\n")
  to_matrix(i[2:end])

  local t = Tile(parse(Int, match(r"\d+", i[1]).match))

  push!(tiles, t)
end
  
