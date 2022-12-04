content = File.read("part1.input")

puts content.split("\n\n")
    .map_with_index { |x, i| {i, x.split("\n")} }
    .map { |x| x[1].reduce(0) { |acc, i| acc + (i.to_i? || 0) } }
    .max
