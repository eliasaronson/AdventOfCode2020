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
    global res = input[i+preamble]
    println("Res: ", res)
    break
  end
end

for n in 1:length(input)
  ans = 0
  m = 0
  while ans < res
    ans += input[n+m]
    m += 1
  end
  if ans == res && m > 1
    pos1 = n
    pos2 = n + m - 1
    println("Ans: ", pos1, " ", pos2)
    println("Fin ans: ", minimum(input[pos1:pos2]) + maximum(input[pos1:pos2]))
  end
end
