inp = open("in6.csv") do file
    read(file, String)
end

cust_dec = split(inp, "\n\n")

#cust_dec = replace(cust_dec, r"\n" => s"")
filter!(e->e≠"\n",cust_dec)
println(cust_dec)

quests = ["a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"]

n_corr = 0
for i in cust_dec
  ans = split(i, "")
  global n_corr += length(intersect(ans, quests))
end

println(n_corr)
