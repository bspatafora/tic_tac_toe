require 'spec_helper'

describe TicTacToe::CommandLineRunner do
  describe '#play' do
    it "should end in a game over" do
      game = TicTacToe::Game.new
      io = TicTacToe::CommandLineIO.new(game)
      runner = TicTacToe::CommandLineRunner.new(io, game)
      expect(io).to receive(:say_game_over)
      runner.play
    end
  end
end
