function turn_knob(line::String, pos::Int)
  operation = line[1]
  number = parse(Int, line[2:end])

  if operation == 'L'
    return (pos - number) % 100
  elseif operation == 'R'
    return (pos + number) % 100
  end
end

let counter = 0
  let pos = 50
    for line in eachline("data.txt")
      pos = turn_knob(String(line), pos)
      if pos == 0
        counter += 1
      end
    end
  end
  println(counter)
end

