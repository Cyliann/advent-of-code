function shoot_beam(starting_pos::CartesianIndex, diagram, checked::Set)

  new_pos = starting_pos + CartesianIndex(1, 0)


  # bounds check, fo beams going out of the diagram
  try
    _ = diagram[new_pos]
  catch
    return 0
  end

  while diagram[new_pos] != '^'
    new_pos += CartesianIndex(1, 0)

    if new_pos[1] > size(diagram)[1] # we're at the bottom
      return 0
    end
  end

  # check if it overlaps with previous beam
  # not optimal, because it retraces the path until first splitter, but I couldn't find a better solution
  if new_pos in checked
    return 0
  end
  push!(checked, new_pos)

  left = new_pos + CartesianIndex(0, -1)
  right = new_pos + CartesianIndex(0, 1)
  return shoot_beam(left, diagram, checked) + shoot_beam(right, diagram, checked) + 1
end

function load_data(path)
  data = stack(readlines(path), dims=1)
  data
end

function main()
  global diagram = load_data("data.txt")

  # locate starting point
  len = length(diagram[1, :])
  source = CartesianIndex(1, len ÷ 2 + 1)

  checked = Set()
  splits = shoot_beam(source, diagram, checked) # off by 1, start is also counted as split, so we have to subtract one
  println(splits)
end
main()
