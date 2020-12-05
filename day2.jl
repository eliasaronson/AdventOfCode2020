using CSV, DataFrames

function correct_check(num, char, password)
  min, max = split(num, '-')
  min, max = parse(Int, min), parse(Int, max)
  
  char = char[1]

  n = 0
  i = 1

  while (global i = findnext(char, password, i)) != nothing
    n += 1
    i += 1
  end

  if n <= max && n >= min 
    return true
  else
    return false
  end
end

in = CSV.read("in2.csv", DataFrame, header=false)

num_corr = 0

for i in 1:length(in[:, 1])
  if(correct_check(in[i, 1], in[i, 2], in[i, 3]))
    global num_corr += 1
  end
end 

println(num_corr)
