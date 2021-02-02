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
    if length(findall(isequal('#'), m)) > 3
      return 'L'
    else
      return '#'
    end
  end

  println("Warning!")
  return "!"
end

function time_step(mat)
  ret = copy(mat)
  for i in 2:(size(mat, 1) - 1)
    for j in 2:(size(mat, 2) - 1)
      ret[i, j] = check_ca_rule(mat[(i-1):(i+1), (j-1):(j+1)], mat[i, j])
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

println(curr)
println(length(findall(isequal('#'), curr)))
