function get_max_index(batteries, i::Int, previous_idx::Int)
  sub = batteries[previous_idx+1:end-12+i]
  index = argmax(sub) + previous_idx
  index
end

function get_max_joltage(bank::String)
  joltage = 0
  batteries = [parse(Int, string(c)) for c ∈ bank]
  previous_idx = 0

  for i in range(1, 12)
    index = get_max_index(batteries, i, previous_idx)
    joltage += batteries[index] * 10^(12 - i)
    previous_idx = index
  end

  # firs_index = argmax(batteries[1:end-1])
  # second_index = argmax(batteries[firs_index+1:end]) + firs_index
  # return 10 * batteries[firs_index] + batteries[second_index]
  return joltage
end

function main()
  joltage = 0
  for line ∈ readlines("./data.txt")
    joltage += get_max_joltage(line)
  end
  println(joltage)
end

main()
