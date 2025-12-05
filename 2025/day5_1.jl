struct Range
  lower::Int
  upper::Int
end


function in_range(id::Int, ranges::Array{Range})
  for range ∈ ranges
    if id >= range.lower && id <= range.upper
      return true
    end
  end
  false
end

function build_range(line::String)
  parts = split(line, '-')
  lower = parse(Int, string(parts[1]))
  upper = parse(Int, string(parts[2]))
  Range(lower, upper)
end

function parse_file(filename::String)
  ranges = Range[]
  ids = Int[]
  past_empty = false

  for line in readlines(filename)
    if line == ""
      past_empty = true
    else
      if past_empty
        push!(ids, parse(Int, line))
      else
        push!(ranges, build_range(line))
      end
    end
  end
  ranges, ids
end

function main()
  counter = 0
  ranges, ids = parse_file("data.txt")

  for id ∈ ids
    if in_range(id, ranges)
      counter += 1
    end
  end
  println(counter)
end

main()
