using CSV, DataFrames

function correct_check(num, char, password)
  min, max = split(num, '-')
  min, max = parse(Int, min), parse(Int, max)
  
  char = char[1]

  if (password[min] == char || password[max] == char) && password[min] != password[max]
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
