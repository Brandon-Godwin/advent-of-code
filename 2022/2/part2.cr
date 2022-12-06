enum Move
    Rock = 1
    Paper = 2
    Scissors = 3
end

def parse_move(input : String)
    case input
    when "A"
        Move::Rock
    when "B"
        Move::Paper
    when "C"
        Move::Scissors
    else
        raise "Unknown move"
    end
end

def get_target_outcome(input : String)
    case input
    when "X"
        Outcome::Loss
    when "Y"
        Outcome::Draw
    when "Z"
        Outcome::Win
    else
        raise "Unknown outcome"
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

    target_outcome = get_target_outcome(moves[1])
    round = Move.values.map {|x| Round.new(x, parse_move(moves[0]))}
        .find {|x| x.outcome == target_outcome}
    
    if round.nil?
        raise "Unexpected error, no round found"
    end
    round
end

puts rounds.reduce(0) { |acc, r| acc + r.score }
