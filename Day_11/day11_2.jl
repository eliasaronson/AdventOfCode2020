function check_ca_rule(m, v)
  m[2, 2] = '0'

  if v == '.'
    return '.'
  end

  if v == 'L'
    if length(findall(isequal('#'), m)) > 0
      return 'L'
    else
      return '#'
    end
  end

  if v == '#'
    if length(findall(isequal('#'), m)) > 4
      return 'L'
    else
      return '#'
    end
  end

  println("Warning!")
  return "!"
end

function find_neigbout(mat, pos1, pos2)
  found = false
  ret = Matrix(undef, 3, 3)
  fill!(ret, '.')

  # Down
  p = pos1 + 1
  while 0 < p < size(mat, 1) && !found
    if mat[p, pos2] == '#'
      ret[3, 2] = '#'
      global found = true
      break
    elseif mat[p, pos2] == 'L'
      ret[3, 2] = 'L'
      global found = true
      break
    end
    p += 1
  end

  # Up
  found = false
  p = pos1 - 1
  while 0 < p < size(mat, 1) && !found
    if mat[p, pos2] == '#'
      ret[1, 2] = '#'
      global found = true
      break
    elseif mat[p, pos2] == 'L'
      ret[1, 2] = 'L'
      global found = true
      break
    end
    p -= 1
  end

  # Right
  found = false
  p = pos2 + 1
  while 0 < p < size(mat, 2) && !(found)
    if mat[pos1, p] == '#'
      ret[2, 3] = '#'
      global found = true
      break
    elseif mat[pos1, p] == 'L'
      ret[2, 3] = 'L'
      global found = true
      break
    end
    p += 1
  end

  # Left
  found = false
  p = pos2 - 1
  while 0 < p < size(mat, 2) && !(found)
    if mat[pos1, p] == '#'
      ret[2, 1] = '#'
      global found = true
      break
    elseif mat[pos1, p] == 'L'
      ret[2, 1] = 'L'
      global found = true
      break
    end
    p -= 1
  end

  # Left-up
  found = false
  p1 = pos1 - 1
  p2 = pos2 - 1
  while 0 < p1 < size(mat, 1) && !(found) && 0 < p2 < size(mat, 2)
    if mat[p1, p2] == '#'
      ret[1, 1] = '#'
      global found = true
      break
    elseif mat[p1, p2] == 'L'
      ret[1, 1] = 'L'
      global found = true
      break
    end
    p1 -= 1
    p2 -= 1
  end

  # Right-up
  found = false
  p1 = pos1 - 1
  p2 = pos2 + 1
  while 0 < p1 < size(mat, 1) && !(found) && 0 < p2 < size(mat, 2)
    if mat[p1, p2] == '#'
      ret[1, 3] = '#'
      global found = true
      break
    elseif mat[p1, p2] == 'L'
      ret[1, 3] = 'L'
      global found = true
      break
    end
    p1 -= 1
    p2 += 1
  end

  # Left-down
  found = false
  p1 = pos1 + 1
  p2 = pos2 - 1
  while 0 < p1 < size(mat, 1) && !(found) && 0 < p2 < size(mat, 2)
    if mat[p1, p2] == '#'
      ret[3, 1] = '#'
      global found = true
      break
    elseif mat[p1, p2] == 'L'
      ret[3, 1] = 'L'
      global found = true
      break
    end
    p1 += 1
    p2 -= 1
  end

  # Right-down
  found = false
  p1 = pos1 + 1
  p2 = pos2 + 1
  while 0 < p1 < size(mat, 1) && !(found) && 0 < p2 < size(mat, 2)
    if mat[p1, p2] == '#'
      ret[3, 3] = '#'
      global found = true
      break
    elseif mat[p1, p2] == 'L'
      ret[3, 3] = 'L'
      global found = true
      break
    end
    p1 += 1
    p2 += 1
  end

  return ret
end

function time_step(mat)
  ret = copy(mat)
  for i in 2:(size(mat, 1) - 1)
    for j in 2:(size(mat, 2) - 1)
      ret[i, j] = check_ca_rule(find_neigbout(mat, i, j), mat[i, j])
    end
  end
  return ret
end


inp = open("in11.csv")

input = readlines(inp)

seats = Matrix(undef, length(input)+2, length(input[1])+2)
fill!(seats, ".")

for i in 1:length(input)
  for j in 1:length(input[i])
    global seats[i+1, j+1] = input[i][j]
  end
end

curr = seats
prev = Matrix(undef, length(input[1])+2, length(input)+2)
fill!(prev, "!")

steps = 0
while !(curr == prev) && steps < 2000
  global prev = curr
  global curr = time_step(curr)
  global steps += 1
end

neigh = find_neigbout(seats, 6, 5)
println(neigh)
println(length(findall(isequal('#'), curr)))
