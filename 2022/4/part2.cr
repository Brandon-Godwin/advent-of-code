def overlap(a, b : Range)
    a.includes?(b.begin) || a.includes?(b.end) ||
        b.includes?(a.begin) || b.includes?(a.end)
end

input = File.read("part1.input")

ranges = input.split("\n").map do |pair|
    pair.split(",").map do |range|
        r = range.split("-")
        Range.new(r[0].to_i, r[1].to_i)
    end
end

puts ranges.count { |x| overlap(x[0], x[1]) }
