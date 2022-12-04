def priority(c : Char)
    if c < 'a'
        (c.ord - 'A'.ord + 1) + 26
    else
        (c.ord - 'a'.ord + 1)
    end
end

input = File.read("part1.input")

rucksacks = input.split("\n").map do |x|
    compartment_size = (x.size / 2).to_i
    left_compartment = x[0, compartment_size].chars
    right_compartment = x[-compartment_size, compartment_size].chars
    duplicate_item_types = Set.new(left_compartment) & Set.new(right_compartment)
    {left_compartment, right_compartment, duplicate_item_types}
end

puts rucksacks.map{|x| x[2].reduce(0){|acc,i| acc+priority(i)}}.reduce { |a,b| a+b }