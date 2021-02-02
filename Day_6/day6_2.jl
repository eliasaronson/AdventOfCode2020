inp = open("in6.csv") do file
    read(file, String)
end

cust_dec = split(inp, "\n\n")

quests = ["a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"]

#common = Vector{SubString}(undef, 26)

n_corr = 0
for i in cust_dec
  ans_per_person = split(i, "\n")
  #fill!(common, "0")
  local common = split(ans_per_person[1], "")

  for j in 1:(length(ans_per_person))
    println("Before: ", split(ans_per_person[j], ""))
    common = intersect(common, split(ans_per_person[j], ""))
    println("Common: ", common)
  end
    
  println()
  println("Final common: ", common)
  global n_corr += length(intersect(common, quests))
end

println(n_corr)
