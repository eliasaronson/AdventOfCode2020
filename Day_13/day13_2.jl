function check_consec(t, Δt, ids)
  for i in 1:length(ids)
    if ((t + Δt[i]) % ids[i]) != 0
      return false
    end
  end

  return true
end





inp = open("in13.csv")

input = readlines(inp)

ids = split(input[2], ",")
filter!(e -> e ≠ "x", ids)

Δt = Vector{Int}(undef, length(ids))

j = 1
for i in ids
  Δt[j] = findfirst(isequal(i), split(input[2], ",")) - 1
  global j += 1
end

ids = parse.(Int, ids)

#t = 836024966345345-ids[1]*2
t=0
@time while t < 10000000000
  global t += ids[1]
  if check_consec(t, Δt, ids)
    break
  end
end

println(ids)
println(t)
println(Δt)
# Mathematica: t = 37*a, t + 27 = 41 * b, t +37 = 587 * c, t + 55 = 13*d, t + 56 = 19*e, t + 60 = 23*f, t + 66 = 29*g, t + 68 = 733*h, t + 85 = 17*k 
