inp = open("in12.csv")

input = readlines(inp)

println(input)

#[North, west] Pos
pos = [0, 0]
w_point = [1, -10]

for i in input
  if i[1] == 'F'
    pos .+= parse(Int, i[2:end]) * w_point
  end

  if i[1] == 'N'
    w_point[1] += parse(Int, i[2:end])
  elseif i[1] == 'S'
    w_point[1] -= parse(Int, i[2:end])
  elseif i[1] == 'W'
    w_point[2] += parse(Int, i[2:end])
  elseif i[1] == 'E'
    w_point[2] -= parse(Int, i[2:end])
  end

  if i[1] == 'R' || i[1] == 'L'
    i = replace(i, r"R" => s"")
    i = replace(i, r"L" => s"-")
    i = parse(Int, i)

    global w_point = [cosd(i) sind(i); -sind(i) cosd(i)] * w_point


  end
end

dist = abs(pos[1]) + abs(pos[2])

println("Desitination pos: ", pos)
println("Distance: ", dist)

