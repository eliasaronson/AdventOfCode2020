inp = open("in12.csv")

input = readlines(inp)

println(input)

#[North, west] Pos
pos = [0, 0]
dir = 3
dirs = ['W', 'N', 'E', 'S']

for i in input
  if i[1] == 'F'
    i = replace(i, "F" => dirs[dir])
  end

  if i[1] == 'N'
    pos[1] += parse(Int, i[2:end])
  elseif i[1] == 'S'
    pos[1] -= parse(Int, i[2:end])
  elseif i[1] == 'W'
    pos[2] += parse(Int, i[2:end])
  elseif i[1] == 'E'
    pos[2] -= parse(Int, i[2:end])
  end

  if i[1] == 'R' || i[1] == 'L'
    i = replace(i, r"R" => s"")
    i = replace(i, r"L" => s"-")

    turn = parse(Int, i)÷90
    global dir = mod(dir + turn, 4)

    if dir == 0
      global dir = 4
    end
  end
end

dist = abs(pos[1]) + abs(pos[2])

println("Desitination pos: ", pos)
println("Distance: ", dist)

