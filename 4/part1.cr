def overlap(a, b : Tuple)
    (a[0] <= b[0] && a[1] >= b[1]) ||
        (b[0] <= a[0] && b[1] >= a[1])
end

input = File.read("part1.input")

ranges = input.split("\n").map do |pair|
    pair.split(",").map do |range|
        r = range.split("-")
        {r[0].to_i, r[1].to_i}
    end
end

puts ranges.count { |x| overlap(x[0], x[1]) }
