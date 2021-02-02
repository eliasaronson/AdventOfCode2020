using CSV, DataFrames

function password_cheker(pass, req)
  corr = true
  for i in req
    if !occursin(Regex(i), pass)
      corr = false
    end
  end
  return corr
end


req = ["byr" "iyr" "eyr" "hgt" "hcl" "ecl" "pid"]

inp = open("in4.csv") do file
    read(file, String)
end

passports = split(inp, "\n\n")

n_corr = 0
for i in passports
  if password_cheker(i, req)
    global n_corr += 1
  end
end

println(n_corr)
