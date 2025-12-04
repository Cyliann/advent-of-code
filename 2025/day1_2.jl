function rotate(position, operation, distance)
  position = mod(operation(position, distance), 100)
  position
end

function turn_knob(line::String, pos::Int, counter::Int)
  op = +
  operation = line[1]
  number = parse(Int, line[2:end])

  full_turns = number ÷ 100
  number = number % 100
  counter += full_turns


  if operation == 'L'
    op = -
  elseif operation == 'R'
    op = +
  end

  # check if it croses zero point
  if op(pos, number) >= 100 || (op(pos, number) <= 0 && pos != 0)
    counter += 1
  end
  pos = rotate(pos, op, number)

  pos, counter
end

function main()
  counter = 0
  pos = 50
  for line ∈ eachline("data.txt")
    pos, counter = turn_knob(String(line), pos, counter)
  end
  println(counter)
end

main()
