content = File.read("part1.input")

elves_sorted = content.split("\n\n")
    .map_with_index { |x, i| {i, x.split("\n")} }
    .map { |x| {x[0], x[1].reduce(0) { |acc, i| acc + (i.to_i? || 0) }} }
    .sort_by { |x| x[1] }

top_3 = elves_sorted[-3, 3]
puts top_3.reduce(0) { |acc, i| acc + i[1] }