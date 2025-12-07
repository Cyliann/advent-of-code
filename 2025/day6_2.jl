using MLStyle

function solve_exercise(exercise)
  numbers = []
  for item ∈ exercise
    if item == ""
      continue
    end

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
  ncols = length(lines[1])
  number_of_exercises = length(split(lines[1]))

  chars = Matrix{Char}(undef, ncols, nrows)
  data = fill("", number_of_exercises, nrows)
  for (i, line) in enumerate(lines)
    chars[:, i] = [c for c ∈ line]
  end

  i = 1
  j = 1
  for row ∈ eachrow(chars)
    row = filter(x -> x != ' ', row)
    if row == []
      j += 1
      i = 1
      continue
    end

    number = ""
    for (j, c) in enumerate(row)
      number = number * string(c) # '*' concatenates strings
    end

    data[j, i] = number
    i += 1
  end

  # fix by moving the operator to the end
  for row in eachrow(data)
    row[end] = string(row[1][end])
    row[1] = row[1][1:end-1]
  end
  data
end

function main()
  data = load_data("data.txt")

  grand_total = 0
  for exercise ∈ eachrow(data)
    grand_total += solve_exercise(exercise)
  end

  println(grand_total)

end

main()
