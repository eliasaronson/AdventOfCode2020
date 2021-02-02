using CSV, DataFrames

modules = CSV.read("in1.csv", DataFrame, header=false)
#print(modules)

mass = 0

for i in modules[:, 1] 
  for j in modules[:, 1] 
    if i + j == 2020
      println("Part 1: ", i * j)
      break
    end
  end
end 

for i in modules[:, 1] 
  for j in modules[:, 1] 
    for k in modules[:, 1] 
      if i + j + k == 2020
        println("Part 2: ", i * j * k)
        break
      end
    end
  end
end 

