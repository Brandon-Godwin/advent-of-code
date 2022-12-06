MARKER_SIZE = 4

input = File.read("part1.input").chars

offset = nil
(MARKER_SIZE..input.size).each do |i|
    s = Set.new(input[i-MARKER_SIZE..i-1])
    if s.size == MARKER_SIZE
        offset = i
        break
    end
end

puts offset