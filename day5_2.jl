inp = open("in5.csv")
seats = readlines(inp)

#println(seats)
seat_ids = Vector{Int}(undef, length(seats))
all_seat_ids = Vector{Int}(undef, 128*8)

k = 1
for m in 1:128
  for n in 1:8
    all_seat_ids[k] = m*8 + n
    global k += 1
  end
end

j = 1
for i in seats
  i = replace(i, r"F" => s"0")
  i = replace(i, r"B" => s"1")
  i = replace(i, r"L" => s"0")
  i = replace(i, r"R" => s"1")

  i1 = i[1:7]
  i2 = i[8:end]

  row = parse(Int, string(parse(Int, "0b$i1"), base=10))
  col = parse(Int, string(parse(Int, "0b$i2"), base=10))
  seat_ids[j] = row*8 + col
  global j += 1
end

diff = setdiff(all_seat_ids[80:900], seat_ids)
println(diff)
