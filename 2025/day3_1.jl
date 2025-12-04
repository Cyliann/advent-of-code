function get_max_joltage(bank::String)
  batteries = [parse(Int, string(c)) for c ∈ bank]
  firs_index = argmax(batteries[1:end-1])
  second_index = argmax(batteries[firs_index+1:end]) + firs_index
  return 10 * batteries[firs_index] + batteries[second_index]
end

function main()
  joltage = 0
  for line ∈ readlines("./data.txt")
    joltage += get_max_joltage(line)
  end
  println(joltage)
end

main()
