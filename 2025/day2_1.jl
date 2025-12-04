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

function check_invalid(id_range::Id_range, invalid)
  for id ∈ range(id_range.start, stop=id_range.finish)
    len = length(string(id))
    if len % 2 != 0
      continue
    end
    pivot = len ÷ 2
    left = string(id)[1:pivot]
    right = string(id)[pivot+1:end]

    if left == right
      invalid += id
    end
  end
  invalid
end

let invalid = 0
  for id_range ∈ get_ids()
    invalid = check_invalid(id_range, invalid)
  end
  println(invalid)
end
