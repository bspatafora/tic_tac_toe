require 'spec_helper'

describe TicTacToe::Game do
  let(:board) { TicTacToe::Board.new }
  let(:game) { TicTacToe::Game.new(board) }

  describe '#make_move' do
    it "sends the move to its board object" do
      expect(board).to receive(:place).with(0, :X)
      game.make_move(0)
    end

    it "rotates the tokens after a move" do
      game.make_move(0)
      expect(game.tokens.first).to eql(:O)
    end
  end
end
