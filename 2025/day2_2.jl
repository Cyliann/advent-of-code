struct Id_range
  start::UInt
  finish::UInt
end

function make_range(str::SubString)
  start, finish = split(str, '-')
  Id_range(parse(UInt, start), parse(UInt, finish))
end

function get_ids()
  line = readline("./data.txt")
  ranges_str = split(line, ',')
  ranges = map(make_range, ranges_str)
  ranges
end

function is_repeated(id::String, chunks::Int)
  if length(id) % chunks != 0
    return false
  end

  offset = length(id) ÷ chunks
  start = offset
  stop = 2 * offset
  pattern = id[1:offset]

  for _ in range(1, stop=chunks - 1)
    part = id[start+1:stop]
    if part != pattern
      return false
    end
    start = stop
    stop += offset
  end

  true
end

function check_invalid(id_range::Id_range)
  counter = 0
  for id ∈ range(id_range.start, stop=id_range.finish)
    len = length(string(id))
    for i in range(2, stop=len)
      if is_repeated(string(id), i)
        counter += id
        break
      end
    end
  end
  counter
end

let invalid = 0
  for id_range ∈ get_ids()
    invalid += check_invalid(id_range)
  end
  println(invalid)
end
