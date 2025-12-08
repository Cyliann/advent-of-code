using LinearAlgebra

const NUMBER_OF_MERGES = 1000
const NUMBER_OF_LARGEST_CIRCUTS = 3

struct Distance
  a::Vector
  b::Vector
  r::Float64
end


function main()
  boxes = load_positions("data.txt")
  distances = calculate_distances(boxes)
  groups, group_ids = generate_groups(boxes)

  number_of_merges = 0
  for distance ∈ distances
    if number_of_merges >= NUMBER_OF_MERGES
      break
    end

    merge_groups(groups, group_ids, distance.a, distance.b)
    number_of_merges += 1
  end

  lens = collect(length(group) for group in groups)
  sort!(lens, rev=true)
  println(reduce(*, lens[1:NUMBER_OF_LARGEST_CIRCUTS]))
end

function load_positions(path::String)
  data = Vector[]

  for line in readlines(path)
    x, y, z = split(line, ',')
    pos = Vector{Int64}([parse(Int, x), parse(Int, y), parse(Int, z)])
    push!(data, pos)
  end

  data
end

function calculate_distances(boxes::Array{Vector})
  distances = Distance[]
  for (i, box) in enumerate(boxes)
    for box2 in boxes[i+1:end]
      r = norm(box - box2)
      push!(distances, Distance(box, box2, r))
    end
  end
  sort!(distances, by=x -> x.r)
  distances
end

function generate_groups(boxes)
  groups = Vector[]
  group_ids = Dict()
  for (i, box) ∈ enumerate(boxes)
    push!(groups, [box])
    group_ids[box] = i
  end
  groups, group_ids
end

function merge_groups(groups, group_ids, box1, box2)
  id1 = group_ids[box1]
  id2 = group_ids[box2]

  # already in the same group, do nothing
  if id1 == id2
    return
  end

  # move all boxes from group 2 to group 1
  # and update their group id
  for box ∈ groups[id2]
    push!(groups[id1], box)
    group_ids[box] = id1
  end

  # empty group 2
  # we can't delete it, because it messes up indices
  groups[id2] = []
end


main()
