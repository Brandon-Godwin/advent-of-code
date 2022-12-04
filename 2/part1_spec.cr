require "spec"
require "./part1.cr"

describe Round do
  describe "#outcome" do
    it "correctly identifies wins" do
      r = Round.new(Move::Rock, Move::Scissors)
      r.outcome.should eq Outcome::Win

      r = Round.new(Move::Paper, Move::Rock)
      r.outcome.should eq Outcome::Win

      r = Round.new(Move::Scissors, Move::Paper)
      r.outcome.should eq Outcome::Win
    end

    it "correctly identifies draws" do
      r = Round.new(Move::Rock, Move::Rock)
      r.outcome.should eq Outcome::Draw

      r = Round.new(Move::Paper, Move::Paper)
      r.outcome.should eq Outcome::Draw

      r = Round.new(Move::Scissors, Move::Scissors)
      r.outcome.should eq Outcome::Draw
    end

    it "correctly identifies losses" do
      r = Round.new(Move::Scissors, Move::Rock)
      r.outcome.should eq Outcome::Loss

      r = Round.new(Move::Rock, Move::Paper)
      r.outcome.should eq Outcome::Loss

      r = Round.new(Move::Paper, Move::Scissors)
      r.outcome.should eq Outcome::Loss
    end
  end
end