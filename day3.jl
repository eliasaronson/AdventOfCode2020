using CSV, DataFrames


inp = CSV.read("in3.csv", DataFrame, header=false)

function three_counter_path(d, r)
  n_threes = 0
  pos = 1

  for col in inp[1:d:end, 1]
    if col[pos] == '#'
      n_threes += 1
    end
    pos = mod(pos+r, length(col))
    if pos == 0
      pos = 31
    end
  end
  return n_threes
end

down = [1, 1, 1, 1, 2]
right = [1, 3, 5, 7, 1]

res = 1
for i in 1:length(right)
  global res = res*three_counter_path(down[i], right[i])
end

println(res)
