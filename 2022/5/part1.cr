stacks = [
    ['B', 'S', 'J', 'Z', 'V', 'D', 'G'],
    ['P', 'V', 'G', 'M', 'S', 'Z'],
    ['F', 'Q', 'T', 'W', 'S', 'B', 'L', 'C'],
    ['Q', 'V', 'R', 'M', 'W', 'G', 'J', 'H'],
    ['D', 'M', 'F', 'N', 'S', 'L', 'C'],
    ['D', 'C', 'G', 'R'],
    ['Q', 'S', 'D', 'J', 'R', 'T', 'G', 'H'],
    ['V', 'F', 'P'],
    ['J', 'T', 'S', 'R', 'D']
].map { |x| x.reverse }

input = File.read("part1.input")

moves = input.split("\n").map { |x| x.scan(/(\d+)/)}.each do |move|
    cnt = move[0][0].to_i
    from = move[1][0].to_i
    to = move[2][0].to_i

    Range.new(0, cnt-1).each do |i|
        tmp = stacks[from-1].pop
        stacks[to-1].push(tmp)
    end
end

stacks.each { |s| print s.pop }
