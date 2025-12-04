function build_map()
  line_length = length(readline("data.txt"))
  layout = Matrix{Bool}(undef, 0, line_length)

  for line ∈ readlines("data.txt")
    row = falses(line_length)
    for (i, char) ∈ pairs(line)
      row[i] = (char == '@')
    end
    layout = [layout; row']

  end
  layout
end

function is_idx_valid(idx::CartesianIndex, max_len::Int, max_height::Int)
  if idx[1] < 1 || idx[2] < 1 || idx[1] > max_len || idx[2] > max_height
    return false
  end
  true
end

function check_availability(pos, layout)
  counter = 0
  for i in range(-1, 1)
    for j in range(-1, 1)
      # skip yourself
      if i == 0 && j == 0
        continue
      end

      index = pos + CartesianIndex(i, j)

      # checks if index is a valid index
      if !is_idx_valid(index, size(layout)[1], size(layout)[2])
        continue
      end

      if layout[index]
        counter += 1
      end
    end
  end
  return counter < 4
end

function count_rolls(layout::Matrix)
  counter = 0
  rolls = Array{CartesianIndex}(undef, 0)
  for pos in CartesianIndices(layout)
    if !layout[pos]
      continue
    end

    if check_availability(pos, layout)
      counter += 1
      push!(rolls, pos)
    end
  end
  counter, rolls
end

function remove_rolls(layout::Matrix)
  total_count = 0
  previous_roll_count = -1

  while previous_roll_count != 0
    roll_count, rolls = count_rolls(layout)

    for roll ∈ rolls
      layout[roll] = false
    end

    previous_roll_count = roll_count
    total_count += roll_count
  end

  total_count
end

function main()
  layout = build_map()
  roll_count = remove_rolls(layout)
  println(roll_count)
end

main()
