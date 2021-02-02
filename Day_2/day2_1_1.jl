open("in2.csv") do file
i=0

for line ∈ readlines(file)
  low, high, char, pass = match(r"(\\d+).(\\d+).(\\w): (\\w+)", line).captures #Get policy and password

  #use regex again to check password
  (parse(Int,low) ≤ length(\[ \_ for \_ ∈ eachmatch(Regex("$char"),pass)\]) ≤ parse(Int,high)) && (i+=1)
end;
print(i);
end

