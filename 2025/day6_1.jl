using MLStyle

function solve_exercise(exercise)
  numbers = []
  for item ∈ exercise
    try
      number = parse(Int, item)
      push!(numbers, number)
    catch
      operator = @match item begin
        "+" => +
        "*" => *
      end
      return reduce(operator, numbers)
    end
  end
end

function load_data(path::String)
  lines = readlines(path)
  nrows = length(lines)
  ncols = length(split(lines[1]))

  data = Matrix{String}(undef, nrows, ncols)

  for (i, line) in enumerate(lines)
    data[i, :] = split(line)
  end
  data
end

function main()
  data = load_data("data.txt")

  grand_total = 0
  for exercise ∈ eachcol(data)
    grand_total += solve_exercise(exercise)
  end

  println(grand_total)
end

main()
