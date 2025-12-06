mutable struct Range
  lower::Int
  upper::Int
end

function count_fresh_ids(ranges::Array{Range})
  counter = 0
  for notrange ∈ ranges
    counter += notrange.upper - notrange.lower + 1
  end
  counter
end

# Loops through all ranges, combining them one by one if they overlap.
# For every range it checks all subsequent ranges and removes them if they overlap, updating the top bound
function combine_ranges(sorted_ranges::Array{Range})
  i = 1
  while i <= length(sorted_ranges)
    lrange = sorted_ranges[i]
    # start inner loop from next range, since all before that are already checked by previous loops
    j = i + 1
    while j <= length(sorted_ranges)
      rrange = sorted_ranges[j]

      # since ranges are already sorted by lower bound, we don't have to check if it's bigger or equal, because it always is
      # we only check to upper bound
      if lrange.upper >= rrange.lower
        # we check if rrange is not completely contained
        if rrange.upper > lrange.upper
          lrange.upper = rrange.upper
        end
        # remove rrange, since it overlaps
        deleteat!(sorted_ranges, j)
        continue
      end
      j += 1
    end
    i += 1
  end
  sorted_ranges
end

function build_range(line::String)
  parts = split(line, '-')
  lower = parse(Int, string(parts[1]))
  upper = parse(Int, string(parts[2]))
  Range(lower, upper)
end

function parse_file(filename::String)
  ranges = Range[]

  for line in readlines(filename)
    if line == ""
      break
    end
    push!(ranges, build_range(line))
  end
  ranges
end

function main()
  ranges = parse_file("data.txt")
  # thanks reddit for telling me to sort them first
  sorted_ranges = sort!(ranges, by=x -> x.lower)
  combined_ranges = combine_ranges(sorted_ranges)
  counter = count_fresh_ids(combined_ranges)
  println(counter)
end

main()
