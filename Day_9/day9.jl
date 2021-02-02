inp = open("in9.jl")

input = readlines(inp)

input = parse.(Int, input) 
println(input)

preamble = 25

function check_pair(val, vec)
  for i in 1:length(vec)
    for j in 1:length(vec)
      if i != j
        if vec[i] + vec[j] == val
          return true
        end
      end
    end
  end
  return false
end
        
for i in 1:(length(input)-preamble)
  if !(check_pair(input[i+preamble], input[i:i+preamble]))
    println("Res: ", input[i+preamble])
    break
  end
end

