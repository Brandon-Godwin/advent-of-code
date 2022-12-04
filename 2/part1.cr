enum Move
    Rock = 1
    Paper = 2
    Scissors = 3
end

def parse_move(input : String)
    case input
    when "A", "X"
        Move::Rock
    when "B", "Y"
        Move::Paper
    when "C", "Z"
        Move::Scissors
    else
        raise "Unknown move"
    end
end

enum Outcome
    Win = 6
    Draw = 3
    Loss = 0
end

class Round
    def initialize(your_move : Move, opponent_move : Move)
        @your_move = your_move
        @opponent_move = opponent_move
    end

    def score
        self.outcome.to_i + @your_move.to_i
    end

    def outcome
        if @your_move == @opponent_move
            Outcome::Draw
        elsif (@your_move == Move::Rock && @opponent_move == Move::Scissors) ||
                (@your_move == Move::Paper && @opponent_move == Move::Rock) ||
                (@your_move == Move::Scissors && @opponent_move == Move::Paper)
            Outcome::Win
        else
            Outcome::Loss
        end
    end
end

input = File.read("part1.input")

rounds = input.split("\n").map do |x|
    moves = x.split(" ")
    Round.new(parse_move(moves[1]), parse_move(moves[0]))
end

puts rounds.reduce(0) { |acc, r| acc + r.score }
