function rule_check(m, w, pos)

  if m[pos[1], pos[2], pos[3], pos[4]] == '#'
    if 2+1 <= length(findall(isequal('#'), m[w.+pos[1], w.+pos[2], w.+pos[3], w.+pos[4]])) <= 3+1
      return '#'
    else
      return '.'
    end

  elseif m[pos[1], pos[2], pos[3], pos[4]] == '.'
    if length(findall(isequal('#'), m[w.+pos[1], w.+pos[2], w.+pos[3], w.+pos[4]])) == 3
      return '#'
    else
      return '.'
    end

  else
    println("State error!")
  end
end

function time_step(m, w)
  ret = Array{Char}(undef, size(m) .+ 4)
  fill!(ret, '.')
  ret[3:size(m, 1)+2, 3:size(m, 2)+2, 3:size(m, 3)+2, 3:size(m, 4)+2] = m
  m = copy(ret)

  for i in 2:(size(m, 1) - 1)
    for j in 2:(size(m, 2) - 1)
      for k in 2:(size(m, 3) - 1)
        for l in 2:(size(m, 4) - 1)
          ret[i, j, k, l] = rule_check(m, w, [i, j, k, l])
        end
      end
    end
  end
  return ret
end

inp = open("in17.csv")
input = readlines(inp)

start_slice = Array{Char}(undef, length(input), length(input[1]), 1, 1)

for (idx1, i) in enumerate(input)
  i = split(i, "")
  for (idx2, j) in enumerate(i)
    start_slice[idx1, idx2] = j[1]
  end
end

fin = time_step(start_slice, -1:1)

for i in 1:5
  global fin = time_step(fin, -1:1) 
end

println(length(findall(isequal('#'), fin)))
