using CSV, DataFrames

function password_cheker(pass, req)
  println(pass)

  corr = true
  for i in req
    if !occursin(i, pass)
      println("Initial")
      corr = false
    end
  end

  if corr
    corr = input_checker(pass, req)
  end

  println()
  return corr
end

function input_checker(pass, req)
  byr = match(req[1], pass)
  iyr = match(req[2], pass)
  eyr = match(req[3], pass)
  hgt, hgt_unit = match(req[4], pass).captures

  corr_extra = true

  if !(1920 <= (parse(Int, byr.match)) <= 2002)
    println("byr, wrong year")
    corr_extra = false
  end

  if !(2010 <= (parse(Int, iyr.match)) <= 2020)
    println("iyr, wrong year")
    corr_extra = false
  end

  if !(2020 <= (parse(Int, eyr.match)) <= 2030)
    println("eyr, wrong year")
    corr_extra = false
  end

  if hgt_unit == "cm"
    if !(150 <= parse(Int, hgt) <= 193)
      println("hgt, cm")
      corr_extra = false
    end
  elseif hgt_unit == "in"
    if !(59 <= parse(Int, hgt) <= 76)
      println("hgt, in")
      corr_extra = false
    end
  end
  return corr_extra
end

req = [r"(?<=byr:)\d+" r"(?<=iyr:)\d+" r"(?<=eyr:)\d+" r"(?<=hgt:)(\d+)(cm|in)" r"(?<=hcl:#)[a-f|0-9]{6}\b" r"(?<=ecl:)(amb|blu|hzl|brn|gry|grn|oth)" r"(?<=pid:)(\d{9})\b"]

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
