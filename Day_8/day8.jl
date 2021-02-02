function run_boot(pos, mat, done)
  acc = 0
  succ = false
  if in(pos, done)
    return acc, false
  elseif pos > size(mat, 1)
    return acc, true
  else
    push!(done, pos) 
    if mat[pos, 1] == "nop"
      add, succ = run_boot(pos+1, mat, done)
      acc += add
    elseif mat[pos, 1] == "acc"
      acc += mat[pos, 2]
      add, succ = run_boot(pos+1, mat, done)
      acc += add
    elseif mat[pos, 1] == "jmp"
      add, succ = run_boot(pos + mat[pos, 2], mat, done)
      acc += add
    end
  end

  return acc, succ
end

inp = open("in8.csv")

instr = readlines(inp)

mat = Matrix(undef, length(instr), 2)

j = 1
for i in instr
  local comm, arg = match(r"^(\w+) (.\d+)$", i).captures
  arg = parse(Int, arg)

  mat[j, 1] = comm
  mat[j, 2] = arg
  global j += 1
end


done = Set{Int64}()
final_accu, succ = run_boot(1, mat, done)

println("Accumulator at reloop: ", final_accu, ". Program ended successfuly: ", succ)
