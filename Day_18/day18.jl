inp = open("in18.csv")
input = readlines(inp)

function find_match_pare(s, pos)
  n_close = 1

  i = 0
  for c in s[pos:end]
    if c == ')'
      n_close -= 1
    elseif c == '('
      n_close += 1
    end

    if n_close == 0
      return (0:i-1) .+ pos
    end

    i += 1
  end

  println("Error")
end

function operate(s)
  println("Initial: ", s)

  if !(occursin(r"(\+|\*)", s))
    return match(r"(\d+)", s).match
  end

  if s[1] == '('
    par = find_match_pare(s, 2)
    println("t: ", par)
    println("t: ", s[par])
    return operate(operate(s[par]) * s[(par[end]+2):end])
  elseif occursin(r"^(\d+)(\+|\*)(\d+)", s)
    m = match(r"^(\d+)(\+|\*)(\d+)", s)
    println("m: ", m)
    d1, oper, d2 = m.captures
    println(d1, oper, d2)
    if oper == "+"
      sum = parse(Int, d1) + parse(Int, d2)
      println("Sum: ", sum)
      s = "$sum" * s[m.offsets[end]+length(d2):end]
      return operate(s)
    else
      mutli = parse(Int, d1) * parse(Int, d2)
      s = "$mutli" * s[(m.offsets[end])+length(d2):end]
      println("Multi: ", mutli)
      println("S: ", mutli)
      return operate(s)
    end
  elseif occursin(r"\d+(\+|\*)\(", s)
    par = find_match_pare(s, findfirst(isequal('('), s)+1)
    s = operate(s[1:(par[1]-2)] * operate(s[par]) * s[(par[end]+2):end])
  end
end


#test = "((8 * 2 * 7 + 6 + 2 * 7) * 8 * (9 + 8 * 9 * 2)) + 8 + 2 * ((8 + 5 * 7 + 8 + 9) + 4 * (4 * 5 + 9 + 6 * 8) + 9 + 6 * 7) * 5 + 7"     

res = Array{Int}(undef, length(input))

for (inx, i) in enumerate(input)
  i = filter(x -> !isspace(x), i)
  res[inx] = parse(Int, operate(i))
end

println("Res: ", sum(res))



#if occursin(r"^\(+", input)
  #d1, oper, d2 = match(r"^\(+(\d+) ", input)
