function main()
  tiles = load_data("data.txt")

  println(find_max_area(tiles))
end

function load_data(path::String)
  tiles = [
    let (x, y) = split(line, ',')
      (parse(Int, x), parse(Int, y))
    end for line in readlines(path)
  ]
  tiles
end

function find_max_area(tiles)
  max_area = 0
  for (i, p1) in enumerate(tiles)
    for p2 in tiles[i+1:end]
      area = abs(p1[1] - p2[1] + 1) * abs(p1[2] - p2[2] + 1)
      # coordinates are inclusive, that's why +1, 
      # e.g. rectangle made of the same corner point will should still have area of 1
      max_area = max(area, max_area)
    end
  end
  max_area
end

main()
