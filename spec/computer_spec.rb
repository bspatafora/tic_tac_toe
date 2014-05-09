require 'spec_helper'

describe TicTacToe::Computer do
  describe '#make_move' do
    it "returns a valid move" do
      game = TicTacToe::Game.new
      computer = TicTacToe::Computer.new(game)
      game.place(0)
      expect(computer.make_move).to eql(1)
    end
  end
end
