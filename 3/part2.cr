def priority(c : Char)
    if c < 'a'
        (c.ord - 'A'.ord + 1) + 26
    else
        (c.ord - 'a'.ord + 1)
    end
end

input = File.read("part1.input")

puts input.split("\n").in_groups_of(3)
    .map { |group| (Set.new(group[0].not_nil!.chars) & Set.new(group[1].not_nil!.chars) & Set.new(group[2].not_nil!.chars)).first }
    .reduce(0){ |acc,i| acc+priority(i) } 
