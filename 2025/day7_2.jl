function shoot_beam(starting_pos::CartesianIndex, diagram, checked::Dict)
  # bounds check, fo beams going out of the diagram
  try
    _ = diagram[starting_pos]
  catch
    return 0
  end

  new_pos = starting_pos + CartesianIndex(1, 0)

  while diagram[new_pos] != '^'
    new_pos += CartesianIndex(1, 0)

    if new_pos[1] > size(diagram)[1] # we're at the bottom
      return 1
    end
  end

  # check if it overlaps with previous beam
  # not optimal, because it retraces the path until first splitter, but I couldn't find a better solution
  if new_pos in keys(checked)
    return checked[new_pos]
  end

  left = new_pos + CartesianIndex(0, -1)
  right = new_pos + CartesianIndex(0, 1)

  value = shoot_beam(left, diagram, checked) + shoot_beam(right, diagram, checked)
  checked[new_pos] = value
  return value
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

  checked = Dict()
  splits = shoot_beam(source, diagram, checked)
  println(splits)
end
main()
